Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739154E8E04
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286916; cv=none; b=R26TdJWh2Y6YXVD2piv35ITd/jv9v3hftdOswLDDfHMCwreghb9xQ4KxARk12GUId/I0HIiWIRjSTnfi9yQJa0COvLFdN4PZUUHK9dzozqpiZ6uAk8II++ZSZflFQZvysMXDl5aDVccYlwuk4hsFc0i92LXJt5FSNEt1NMHqqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286916; c=relaxed/simple;
	bh=AmAFroaXL17QSnFsH/PQWr/UvsxMnLiTjSzJHT5lPFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZH86g6t+wVQCGltlVh+87DgHw/PTke4gc4js1/NXp1p8L0VPlqAQmAfZ72DI3VroeUzndmxfgUtqDNYh2Y1PUcI0KASpqc/dXlewaqgEthyoP7D8W/+49rKnzRdj0QKkDwrL5LjLYQxL8ckPSEWX1kiHeoK+R6Mx6EVuopXgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jx3O5O0O; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jx3O5O0O"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so137251a12.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286914; x=1790891714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezHhSJt+7qSkRvAzEm8z+BVF8AxbcHuofPSZIn2ErA4=;
        b=Jx3O5O0OQbOrlSv8FPt37hOWlflcYKIJzV6Q2m28y7mU9zlKOexP+3gDgCCVAoy4FH
         aOytYokS0GgY9vaWVMiSv2mlApxM5GO6eWPNaQ5mN2k/3LvoC+8u1DzEoG7aFhZ9SJQA
         kSAZhQQaNBsT/+Iy5VWR+CCS3UIWB03v9giPVjNOBJ/aeAGuzmb0Ru00Til+ODvBVl7c
         bINxc5F5k/bBHiv8KkKW4PH2zPjrCnUQ9Nkx7DoN8zuxySuFd2jxy7sMXrEOy4PqRvgT
         rcrndTxnegLxomveVSj9Gpcnzpliv72NV1tEXtC+nufhFeOj2ZQXs9uGqmmMtpxII1yT
         1GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286914; x=1790891714;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezHhSJt+7qSkRvAzEm8z+BVF8AxbcHuofPSZIn2ErA4=;
        b=w9IQudrGsPnCrVzGBkihwpuxgWtxtw/QtbvKwD9lbtSPVAUT9Buro2VAL2vY498Muo
         ewARAJcR00PPqBiwsEcU/F8llAEx5/suMWyFWh8OSb4Us36oc2PS+sc/eFrbV716YOHF
         LXUgn2Ap+qQ0zxmvkUCbrdTKtctw0DM0dBdPe4ctLm0CR4k0RUyzNxKojcPNUtquGKYC
         v6XCkDH9EDMLd8gZaPl5B/gsVWQGlmBz5PU7qGnIWSxygjq40tlAxhj0D1B4qh5AouOn
         B3w+VJBjXbwTSCKnfqAoUxjI0Ldt0TOkarNUfFlC55yPr6BbityL0G647VesLNxvHTF4
         XRGw==
X-Forwarded-Encrypted: i=1; AKwUvByuu6P4CqJ7EeWWZIKf3iYkxwLJJ6AqLEIq3Rd+2qAqIQkPv3Y1aRQDcMeq+2O0IPk6Ht0=@vger.kernel.org
X-Gm-Message-State: AFuF++k9DtMSEMC3KFhU5ib7k22zV6Vc1Q4q92n8RFAiEKkVu/jWPOgD
	bVc2/7b6BzZHAX5lObInO4R3dSvHTl4W7A134CU4r73/4zm6NmosMlC6gv93zuouD4lD7gDz7iR
	tLWI/cQ==
X-Received: from pgte15.prod.google.com ([2002:a65:688f:0:b0:cc7:80f9:3931])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d21:b0:3dd:a196:30a6
 with SMTP id adf61e73a8af0-3de0e9b22f2mr3581598637.86.1790286913447; Thu, 24
 Sep 2026 14:55:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:52:09 -0700
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028366994.2006772.3458650384627466944.b4-ty@b4>
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for TDX
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	nik.borisov@suse.com
Content-Type: text/plain; charset="utf-8"

On Wed, 19 Aug 2026 17:48:54 +0800, Xiaoyao Li wrote:
> This is v4 of the series to enable the Notify VM Exit and Bus Lock VM
> exit for TDX, which fixes the KVM CAP issue related with them and allow
> userspace to actually enable the features.
> 
> Compared to v3, this v4 adds 5 more patches.  The first 8 patches target
> for stable kernels while only the patch 9 doesn't have to.  Patch 1 is a
> single patch to enable Notify VM exit for TDX.  Except patch 6, patch
> 2-7 are mandatory for enabling Bus Lock VM exit for TDX in patch 8.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/9] KVM: TDX: Enable Notify VM exit
      https://github.com/kvm-x86/linux/commit/d93395058c19
[2/9] KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
      https://github.com/kvm-x86/linux/commit/0966c881ea13
[3/9] KVM: TDX: Set bits 31:16 to 0 for the synthesized Exit Reason
      https://github.com/kvm-x86/linux/commit/b43c520b198a
[4/9] KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
      https://github.com/kvm-x86/linux/commit/bc335ce04408
[5/9] KVM: TDX: Update exit_reason on wait_for_sept_zap return
      https://github.com/kvm-x86/linux/commit/e5f1d62c59ae
[6/9] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
      https://github.com/kvm-x86/linux/commit/cef48693da1e
[7/9] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
      https://github.com/kvm-x86/linux/commit/326fa2c9b4d3
[8/9] KVM: TDX: Enable Bus Lock VM exit
      https://github.com/kvm-x86/linux/commit/63d196e2e204
[9/9] KVM: VMX: Consolidate the exit handler for VMX and TDX
      https://github.com/kvm-x86/linux/commit/213bbf18f07a

--
https://github.com/kvm-x86/linux/tree/next
