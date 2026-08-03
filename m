Received: from na1pdmzitismtp02.tibco.com (na1pdmzitismtp02.tibco.com [160.101.131.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55F35AC2C;
	Mon,  3 Aug 2026 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.101.131.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798162; cv=none; b=ZB3nxJ5xBBYtRU05xjeLhbGbmIEUMRvcSnmIq1Xfdn7KOWI94mL522rsIwIxBGFBU1Y+ktFhKK7c/rt9ppGW1ov8PZr3WZZytfjj5IrKrE4dX5KB4bxu2s0am8K8X0Zu+mfGaCoB8uhvHAAUd8lBzxk1qVhxdULS3MEa5t5rsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798162; c=relaxed/simple;
	bh=8zLKPjCgFqXe3/yeXvAH5V2cPyamCYMyY8ojaeHg3g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKgnD0N+XnGL7XwXuK0Pcy7hrnYP2Q5/P41usakelpiZbix7c6MKanCl191MzSQ3KlQ+dmc2i3yCMUWDCIMEeHqJ8twMgPR5cx6zRIOh3pePn09tLsoD+5NGuZ8x6VlLlGkF8pTuA1HhdCsHyKa8jBFb6KRhXQhCh5pH934SiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; arc=none smtp.client-ip=160.101.131.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from fedora.eng.citrite.net (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id DCBB582E75F2;
	Mon,  3 Aug 2026 18:55:20 -0400 (EDT)
From: Abdelkareem Abdelsaamad <abdelkareem.abdelsaamad@citrix.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	teddy.astie@vates.tech,
	jbeulich@suse.com,
	andrew.cooper3@citrix.com,
	roger.pau@citrix.com,
	jason.andryuk@amd.com
Subject: Re: [PATCH v7 17/26] KVM: nSVM: Add missing consistency check for EVENTINJ
Date: Mon,  3 Aug 2026 23:54:02 +0100
Message-ID: <20260803225402.2324595-1-abdelkareem.abdelsaamad@citrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303003421.2185681-18-yosry@kernel.org>
References: <20260303003421.2185681-18-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,
I am currently working on hardening the Xen hypervisor's nested SVM
implementation to add the VMRUN consistency checks for injected events,
see the Xen patch discussion thread in [1].

While reviewing KVM's logic in nested_svm_event_inj_valid_exept(), I
can see that BR_VECTOR (5) and OF_VECTOR (4) are treated as
unconditionally valid. The referenced AMD APM Vol 2, Section 15.20
explicitly state otherwise:
"If the VMM attempts to inject an event that is impossible for the
guest mode (e.g., a #BR exception when the guest is in 64-bit mode),
the event injection will fail... VMRUN will immediately exit with
VMEXIT_INVALID."
"Injecting an exception (TYPE = 3) with vectors 3 or 4 behaves like
a trap raised by INT3 and INTO instructions, respectively"

Also, the APM volume 3 chapter 3 (INTO instruction), states that the
#OF triggering instruction, INTO, is Invalid in 64-bit mode.

I attempted testing the injection with Xen-Testing-Framework (XTF)
bare-minimum testing setup. I injected an exception (TYPE=3) with the
named vectors (BR_VECTOR (5) and OF_VECTOR (4)) on Genoa host. They
both caused VMEXIT_INVALID.

I think the check in nested_svm_event_inj_valid_exept() needs to be
gated on a condition that only allows Type 3 exception injections for
OF_VECTOR (4) and BR_VECTOR (5) when the guest is not in 64-bit mode.

Please, could you have a look and share your insights on the
implemented logic?

[1] https://lists.xenproject.org/archives/html/xen-devel/2026-07/msg00808.html

--Abdelkareem
