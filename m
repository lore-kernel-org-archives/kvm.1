Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D90364049
	for <kvm@vger.kernel.org>; Thu,  5 Mar 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749615; cv=none; b=DsUtGhEUGTi4iWkke/F+3DoXTDdAY0pYeZmALTJFFRf6ym5lBGEjLCxYgSvUmieFZWxgkC6iVY4VXMP3vv1/pgqktvLiQjBe9gZSH5lehiq9KoP5gALR2lR80JlX6WbiHWdrrcyqro7/MtMhEQmAeboGPyyh32MgYQOmpDIvr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749615; c=relaxed/simple;
	bh=ckC8e9ScrPoWujr5t7OMT2iQ/3KONFj76Mv1ZZOmSHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vhh12Md5ku0j1P+w01UQuEaymlxQ27G9ZnZERzGwmGmkiZzhYZ5LMAejXknfInuDc19z8QTIodnd8EHlbIfcYLJg4KDkC3qrn+0vL29Y0vKeD8Dyh03XLz1rLFqKCKL3mLOmOYoN7wDL9PNk+JKRKmvkkpIVx+/dm3sJf9CXxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEJJcEpF; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEJJcEpF"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-67999892f00so150920908eaf.3
        for <kvm@vger.kernel.org>; Thu, 05 Mar 2026 14:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749613; x=1773354413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RM07twrcR0dXNaC+0E22+0adMf36n7my8fIoC64KCh0=;
        b=tEJJcEpFBkrs27dXs5vkZwn6zAsKPIrlWLQRHquh/gFqZ3qzuIA+UeTl9TyB1iaU5f
         BeP4a9gwyX/FGnpKtTlgqgxx9XCIn5+oGEDJvFs1oY3KrNaKooTkfwuyRBOdnKT65W26
         5FlvgSEqH6gnlNNx0eUqcb+l0RfyhXqMabVAYJlZgVgj8btSKecAv+tVSqMW0mWnUcTE
         kkqcxLID79HbeMnMvxKEEgngh4VrRlk/7t2OeON04TX4uHqg2rOiZgZlf7wU5M2LpCLa
         IMl0/LCj2V3MoFuEfnsqK0UqASizNytBobz1BXt3MIh7FEAI4E0qxuhy2a6BGFvwIQdr
         kkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749613; x=1773354413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RM07twrcR0dXNaC+0E22+0adMf36n7my8fIoC64KCh0=;
        b=oaK0yJAsGI+rwttOmwQ+eYfFjWFXv2gCFZf9uSEAfzfSjZT67kp9Q1Vm3MXI8BE0Ev
         uW1Z/CeL0imllM8bETiitBeeLJQxVV8nY71FoBUKmvJ2ZTkOYVwMtVqK9HsWIqHTEs5T
         ZrI43wzWFH6Wp6JUEnp7t86P52jPI9FFDf7Z+3soaN5Fzb11x9GoR9DVnb+hJKpc4+n7
         CSLg/+FpiX25F9KTDi/BMaFTf1BFKnp1lhfeG9VMQ5z9FtSbrNvtFAmPHwxg/li8Fi1J
         l/4K9g/9Whdd4J7Yfzg0Z0tRWqLTTkgTBNvKxnogn3R1j/jOD9rGeRjjCozO+0ej84Ur
         WOog==
X-Forwarded-Encrypted: i=1; AJvYcCWdvuRTf3/1IVmn+MPG30wUbaiBip6O1UObjfVeAUwbgJlrDFy6e0jSb4Qz+IvbNW2PcJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNULeY9YtIkmzlv0BtAx1Ep4lZ6e8NXTtO/EldzyggN1P4vPJd
	B2sfcPKZZDGSrNmVwSFJCpyzZ33oJ99l47MXyXnHdRJ+ZKA29cqisVs8EM9/x9QbfJvFQfvOOKz
	lUg==
X-Received: from jablo9.prod.google.com ([2002:a05:6638:aa09:b0:5d1:5187:4cc8])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:228e:b0:676:eb1e:df29
 with SMTP id 006d021491bc7-67b9bcc0e80mr106951eaf.31.1772749612963; Thu, 05
 Mar 2026 14:26:52 -0800 (PST)
Date: Thu,  5 Mar 2026 22:26:25 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305222627.4193305-1-sagis@google.com>
Subject: [PATCH v4 0/2] Extend KVM_HC_MAP_GPA_RANGE api to allow retry
From: Sagi Shahar <sagis@google.com>
To: Vishal Annapurve <vannapurve@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"

In some cases, userspace might decide to split MAP_GPA requests and
retry them the next time the guest runs. One common case is MAP_GPA
requests received right before intrahost migration when userspace
might decide to complete the request after the migration is complete
to reduce blackout time.

This is v4 of the series.

Changes from v3[1]:
 * Rebased on top of v7.0-rc2.
 * Switch "if" statement to switch-case in tdx_complete_vmcall_map_gpa()
   as suggested by Michael Roth.

[1] https://lore.kernel.org/lkml/20260206222829.3758171-1-sagis@google.com/

Sagi Shahar (1):
  KVM: SEV: Restrict userspace return codes for KVM_HC_MAP_GPA_RANGE

Vishal Annapurve (1):
  KVM: TDX: Allow userspace to return errors to guest for MAPGPA

 Documentation/virt/kvm/api.rst |  3 +++
 arch/x86/kvm/svm/sev.c         | 12 ++++++++++--
 arch/x86/kvm/vmx/tdx.c         | 28 +++++++++++++++++++++-------
 arch/x86/kvm/x86.h             |  6 ++++++
 4 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog

