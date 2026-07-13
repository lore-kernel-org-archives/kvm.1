Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70091E1E12;
	Mon, 13 Jul 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963743; cv=none; b=eIVgs5yOlAZwma38c5gakJB9YXFS335xoRx8CF3bSmP4b6fzu2pxFz7EDONT9gsw7KrGO57PmXYOtffRTfsIadI9KmStrJseu9ofodx1eOHptsZ11LEWPn1tdEuG0ZrhiZBGkQHdtWuc0fBRD4eYIELNWu30kgpbE8yX0l/2Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963743; c=relaxed/simple;
	bh=J/WJmEiD138SPCYFDmZ6fDw6vG52ctRUqoLxYoj70x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT3+pgW3ce93scCPfLfugXCmCYJr9MyKfMqST+Zm2AijgS7FVkQcDf9ozwk0gBWH1N1VaUJltsejf3kvbPJ3KZ3ZLh/wiH6POZcLJczhbNwUCpp+bbhHyMoplAaspLn4reV+5Y9fsQyU28Cy3mqxuPwb+benjj2ApovQqThHMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=l7yKkjv0; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="l7yKkjv0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J/WJmEiD138SPCYFDmZ6fDw6vG52ctRUqoLxYoj70x8=; b=l7yKkjv0YgwhzR6E6jm/2dS5cD
	CTb/nUNlRmcZDG9iu7g8YOwSXdxjLYT2Ivs9jVVtpYXIcKwbTCHJ20nEKTAZpa5sVx3V1CuQi804d
	T1zwDXz+ILa9oxnHoFyg88pwFvOYCFpOEBQkFGA+J7/DH3tFHGl1VrFnAg6oM0Zlun7rYmYQqa1Kv
	jyl7426Vh7eXeRr3EEzePDHYCED1Hu/CycdTaEPT317Xsbcp1Vj2fhfY2GeelxV0TZ1pp5xGPrbYV
	7sjqBqE/G1uJ56hqc8mA8EBVNJdtfntPTWhPtx9kPM8eaTRFjs5ZtnLnJ27t3jXiJDBlr1n4uAQFY
	vaTHXK/Q==;
Received: from mailer.gwdg.de ([134.76.10.26]:51164)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wjKSg-009ek7-22;
	Mon, 13 Jul 2026 19:28:58 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wjKSg-000K8n-1u;
	Mon, 13 Jul 2026 19:28:58 +0200
Received: from eftekhar-ubuntu.customer.ask4.lan (10.250.9.200) by
 mbx19-gwd-01.um.gwdg.de (10.108.142.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 13 Jul 2026 19:28:58 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] KVM: nVMX: store L2's TSC frame in the VM-exit IA32_TSC MSR-store list
Date: Mon, 13 Jul 2026 19:28:47 +0200
Message-ID: <20260713172847.12697-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713144605.2773845-1-amirmohammad.eftekhar@cispa.de>
References: <20260713144605.2773845-1-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-SUB-08.um.gwdg.de (10.108.142.73) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

The bot's review is correct -- I'd like to withdraw this patch.

I tested the underlying assumption on real hardware: a single-level (non-nested)
VMX hypervisor that configures a TSC offset for a guest and lists IA32_TSC in
its own VM-exit MSR-store area gets back its *own* TSC frame on exit, not the
guest's. That contradicts the "single-level equivalence" reasoning this patch
was based on. The original code was already correct.

Sorry for the noise -- please disregard this patch.

Amirmohammad
