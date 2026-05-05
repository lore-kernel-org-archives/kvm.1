Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D17A2EA
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945316; cv=none; b=sdfHKSlwRF6JXqs4W9THphofFWIr2zAt/SlvFl8XHbDyhMPKV0FIO7yIvOv5Cso7ov3i6hzDYQ1Rc2XJY8Obga0w/O0ps3goo/NgIYP5JzwSBfyxea9/bUYAj5z8CaUpAju8OPlbg1Noz0oc6fnJfEzm0+MDnTZbQ2KvotNyIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945316; c=relaxed/simple;
	bh=8ymeVEIRfQfXU1NB8HZHrfH6ISjD+L8gEflEZ4uHTVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YYjo/FfF5Cp7JSRtFZYCgJCByLmI5ddGuDh4ao1gRAvbztTgqSQgoDALKldiTZFgcbmS/yqXgzPquO8bE1sX4wTyeDMMBrTqs3c4GkpxnTXow5slmgD9F3VJ9QnOg1D/Qs3wKP2W3FV65HOf5J2dowP/JJgfqXzoWIcX1owYmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqy+pOes; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqy+pOes"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c802862e9f5so2000044a12.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 18:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777945314; x=1778550114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=09pZCJKdOJo9j2iY5tzzUKd0+hE83Q2DSvUvCNdXB8o=;
        b=oqy+pOesUdU8DNrWiiFZ4hZsFmpaUUf6KycoH4QXhtK9eO/KSGFVgrxKJLx0pl/qpi
         VjVh1zhOJK9XlqO4c2y6LMB6YtKFD22kpIYSwAKkz8F70Vc0XrlyD6K4EyNJIMwIN8do
         wmHADVNj5XlDfZD27I3cPd/eep9A9fRvbyWUoGsIXrWMGxN1LkYlyIv9H21rgWzI0NjD
         k0RJlZwnPhdrTcND4WjmtpdnixRz3YHwvMiYqCwpG/z7EHSyju9poI59WpBUzbYdWQEX
         Y7m+IJ06shYz9W/UqSIYUJr1IqmIJKE8Yz2+xvXwVdtNJEqNTUjiWzgWTuE3F4l/ctsq
         4c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945314; x=1778550114;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09pZCJKdOJo9j2iY5tzzUKd0+hE83Q2DSvUvCNdXB8o=;
        b=K47YC2AtDRvFONOb4bDCIrBkr1kt9flNM5jDMRbH4uGdrsdoOLr9ldwVTMEaq4P5Sm
         fdqfCk0KX0NBKczk8Z8tFESjdN33hTXuNedMTVkMWueT3WQlw3LbCd/CCEPznaIOQXlK
         hIObEju7dokypVlpcCzMxpa+rwy34QRSZe2unJqFvBD5fDP5gVaUmVG+SLLVqZ/cE1eK
         4k43bDRaD9Vwm4xV++ZjIRcbA0rdToflDtE6fyMUWSU2bTRcZ1pEXjpLkJYjyIPrLZ0w
         DPlUlkF4ibglWeXr7/VJDQTykjRpd+vl05dMPXm+brrvKg31xLAwO8LAF0hvwT+7BYeQ
         eDkg==
X-Forwarded-Encrypted: i=1; AFNElJ9kUPcPcuMq2CGrf1wSgfiz8JAW5W4OVQ301lI2eMUmMrMmdcKMCEvCiioFYPzk9MRtCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoW7JC2CB5NyCY4NWs+4WAp2DvTuj+hGUE33ovaR7koWahPiV
	3SLfooRgFZb6y7NLOpEAI58sIfBUlBZRVttSR/Iyw53Xv257ioKEY/XiFQIzmuAUlWpCrG+FVxT
	QivuMsv2SfJfvEyQTXBppCQ==
X-Received: from pfbhw22.prod.google.com ([2002:a05:6a00:8916:b0:837:6551:488])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4095:b0:837:acd7:a7d with SMTP id d2e1a72fcca58-83923e98589mr1094865b3a.28.1777945314017;
 Mon, 04 May 2026 18:41:54 -0700 (PDT)
Date: Tue,  5 May 2026 01:41:16 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505014118.3783476-1-vannapurve@google.com>
Subject: [PATCH 0/2] KVM: TDX: Disable PMU virtualization for TDX VMs
From: FirstName LastName <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vishal Annapurve <vannapurve@google.com>

TDX module virtualizes PMU for TDX VMs [1]. KVM has limited role to play
in virtualizing PMU accesses and needs additional enlightenment to
support all toggles provided by TDX module.

This series disables PMU virtualization within KVM for TDX VMs, which is
a safe bet until the complete set of PMU controls are implemented within KVM.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Vishal Annapurve (2):
  KVM: x86: Move the default arch state init before vm_init() call
  KVM: TDX: Disable pmu virtualization for TDX VMs

 arch/x86/kvm/vmx/tdx.c |  6 ++++++
 arch/x86/kvm/x86.c     | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

