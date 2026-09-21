Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D03BBFAE
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999550; cv=none; b=pj/mi/mqXNtcYNgf1HgSQ0JMi6ddQkdUrf4NUXXNRe7OkAOkxZ5xlqiQweGULCiyLVoAyiTvueipvaqTiZNLTpJ4POM2uU5YBtrSmTbrSKHyJxEmswj0G55uf/KJu6pYJ60Hcc819bxhbjd0MPPKGTeCNO86lvUyfM4uI3ssOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999550; c=relaxed/simple;
	bh=kpuHhKP9Bh9hWV0IWYw/KZrp9c3dF4naQ9jbmcc3o1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKsiiqESBZbHRPqcSIkfa/m2MRhHg6+PN5gcZltsupQR1fWDMF30eabioTJvoOD/UGSeFt+stlu7nNnD7Tysuh13u5SrLLcAbSlzwC26UrcmVfsMe3t6yq/zKwGwBspp34Ns0UxLnZPmtLdvF8QLB1z950q2Ak14XMGqju0YGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COwbit7s; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COwbit7s"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd753a52bbso56707165ad.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999548; x=1790604348; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW4sNlq6k287tar6lVhVSvlutTHj4/aiursA/L7sB2A=;
        b=COwbit7s55trjpAdVo1LcAMDI5VjlornmYXsGx8U8BKOQhZ5BGfjPxP0Cpdy0aBnHK
         R0byrfeOZPeMikY2jAEFOiuoAxuui/fe0SEMDBnWHipsfDNyJq4uRBpnU7c5G8290J9C
         WutHCBPG68pNguMa/6F01igTU9/3+0LV8gfBy5kPm8lwRDf2qYxqq+lr133VJ/fjB97W
         VtNvlNqF9SvSGbkQLCOE19blFdPKJRZmoghogr1GCSmHFbo4TyO/kFh19Id4Jj2b9NU3
         4ZXLn0Ev5GfGLLb8S6e3O++fcHbBp52GX4IzzLB3UUSlrcVv/WD3qPdp+9JYW7s8nWsw
         zB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999548; x=1790604348;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MW4sNlq6k287tar6lVhVSvlutTHj4/aiursA/L7sB2A=;
        b=VDVFiueSr4BaygCUiAHn+cy4r9DaZvD3TzpmGJVoPDhm7mhzB4gMuMPVQeb/ty9aqu
         +deho6g1dlOMfY9GOZknz98BgAQrlIv9L7xAf/uhGqRQLlNeD0TFWqQQKbbDjD7i97DZ
         pK07kI8rGKqThACe9idzwXqO2l6b5I7NqtE0QkjclAD+yWc9A6l3QH1QxIpmErulvGB/
         k8i+qe3blyC7k/3p0wPIqhtM8MAV7pZQjTtp4bE/FCxBzOMGU5tYX2+nN7U8I1XN/qLD
         tH7Cm/z20eibi0u9P23S3I5hKGe1tPIfBVXbMqJrs0wSCSwN5oPaW3ZUSzICw7I+iMZH
         zg7A==
X-Gm-Message-State: AFuF++m7RKL5yhRL9rMryLvc66rG9/Jmxh8p64yTGPS19EGf7i03uPhn
	jRoVNRMVaqQ0jJUV1QU+6HEvJxUug5R1+nF1EA5jbDncdZ+VLuX7Q6ZXCCPwdI2vaLqRcaPYPaW
	haOKUaA==
X-Received: from pleb11.prod.google.com ([2002:a17:902:d40b:b0:2db:8a77:fd33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc84:b0:2dd:c053:a6f3
 with SMTP id d9443c01a7336-2ddc053a789mr108960555ad.37.1789999548064; Mon, 21
 Sep 2026 07:05:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:00 -0700
In-Reply-To: <20260902184711.138538-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902184711.138538-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999883078.741107.1140283718969163557.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org, likexu@tencent.com, sandipan.das@amd.com, 
	yosry@kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 02 Sep 2026 11:47:11 -0700, Jim Mattson wrote:
> Commit c85cdc1cc1ea ("KVM: x86/pmu: Move handling PERF_GLOBAL_CTRL and
> friends to common x86") moved the existence check for the following Intel
> PMU MSRs to kvm_pmu_is_valid_msr():
>  - MSR_CORE_PERF_GLOBAL_STATUS
>  - MSR_CORE_PERF_GLOBAL_CTRL
>  - MSR_CORE_PERF_GLOBAL_OVF_CTRL
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()
      https://github.com/kvm-x86/linux/commit/79a71cc2568f

--
https://github.com/kvm-x86/linux/tree/next
