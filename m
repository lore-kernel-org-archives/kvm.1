Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754464A499F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999685; cv=none; b=IypmP25Oe6MSBX6x09DZ2GaHZ/00nPYdgWAW4wkQrs1vDXX3r5WKiY4/Nr9ye1sB1Wq7Vu+ogHTvpVCP6YII2FNou2Mn+PHGnLQUlcS10frrwq3vU4uccKC1SaJhBmVFde7MvKJvuNdVQ+7DsNecNszikXN3ukFClYx9oAahFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999685; c=relaxed/simple;
	bh=jSKjHXaIx5zwGvQfdXRPlWbBb7m/exgMOgSbCKA3lV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=av4xrAzSrtJWn06h+sMBVvYl/AmEuyzmu1QKRE6PjeZI5Tb9tsnWdGgacM/HkmVlte9nGqe6jKrtqR6ZBj4+rlltX8NOBAylP88oGnjJwg6Vk873qu4/7ydP1G8b/uS/TGwBr/aDad44teGfHbSE7j00ZNQ6T6+Skhz2O3ttRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5142kWj; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5142kWj"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso2588932a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999683; x=1790604483; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4nJZF1QiLHrcgDeqtwQduKMWx1Wy46eu0NLAPoTZ+g=;
        b=k5142kWj4BJiRSjyPeZ4DSyyGvK0OLGLbqRU8+pdNzLUbDKLVJEgUackg2n4FsWyjM
         Yx8I2Ey8ukFtCMcAcRRPo6zvjwN3yekwuGoPqszBgxz9sJBjaA+usuJCtRtyH36TyZel
         r7XB+gSwLvbwvWoJIHsCie+1Ry6F/agFAYr6YURTtAmBPL5YmBMmzVkI5OXV835FBPnN
         TACFYnbpdsFsrOGQGvcnJ/zRuBCpagrT+CtzpzKiER9e+OxjIPcdD2m/y1kg2PndCw8y
         78e7EAK9k1xWdvCfY0R6b1STX81XlabZzfANgDMqLeIhwBF/1+EenKly/m9+TIyJwwGc
         q7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999683; x=1790604483;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4nJZF1QiLHrcgDeqtwQduKMWx1Wy46eu0NLAPoTZ+g=;
        b=zI2wJ2mKELRuUbypSekKJ2FoNjdvwU+5uXmreQydggWRTXgoNUfz83Xe51WX3a9h9P
         Q8u0kMWehYQ+FrIr3UN1vrbNdGDRSEh3xO5l4aoSt8/aEqimAV1j/yPx/EBR5EHnNo1R
         Wye/FvCkilpiNALC2NUdUMMTwESQoEa4Re5q2t8HQcUbxovYDFPuq/8O5mGhnnI4OBaB
         5RQ1EOAZu60MEBIeAzVofro0IQ+1/fedshwB+/toMF+LW7wpn2Q9pIPYbVgMSJI322wu
         7cdS+0btNAe039kxGZ/X3RaaMp7vp6AYSIyVQ3laj/KTR9C+hBW7vN8u1lQw+HF2txeG
         LWLg==
X-Gm-Message-State: AFuF++kkdWatVDYHNDdpXa9sGKXYo6ApAePgVIub/QIN49mVj1XaqjGK
	MpJPac0wA6m/mqpAsSCMYuyqppvaeQCDUluvAc6RQ/CMBhH5k+Hn3EO51wu0y2uTW6L/aQbRTiI
	wiat6cw==
X-Received: from pgcg11.prod.google.com ([2002:a05:6a02:14b:b0:cc5:2a1:89d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:68c9:20b0:3dd:a197:7371
 with SMTP id adf61e73a8af0-3dda19774d5mr6470117637.74.1789999682602; Mon, 21
 Sep 2026 07:08:02 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:46 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999933234.758612.12894201721698882453.b4-ty@google.com>
Subject: Re: [PATCH v4 00/17] KVM: nVMX: Adjust VMPTRLD/VMPTRST behavior with
 active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 03 Sep 2026 17:24:06 -0700, Sean Christopherson wrote:
> The first four patches are Vitaly's series to adjust KVM's emulation of
> VMPTRLD/VMPTRST when the vCPU has an active eVMCS to match Hyper-V, and more
> importantly to not put the vCPU into an infinite loop.
> 
> The churn piled on top came from wanting to use KVM_ASM_SAFE() for more VMX
> instructions to verify the RFLAGS bug+fix Sashiko pointed out, lack impulse
> control when it comes to cleanups, and Yosry being a bad/good influence.
> 
> [...]

Applied to kvm-x86 selftests.  Yes, really, that's not a typo.  I didn't want
to split the nVMX fixes from their testcases, and this series ended up being
99% selftests and 1% nVMX.

[01/17] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
        https://github.com/kvm-x86/linux/commit/35097cefedaf
[02/17] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
        https://github.com/kvm-x86/linux/commit/5b1acaadcdcb
[03/17] KVM: selftests: Don't clobber RFLAGS in happy path of __KVM_ASM_SAFE()
        https://github.com/kvm-x86/linux/commit/be7875808fcd
[04/17] KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used
        https://github.com/kvm-x86/linux/commit/455919e76945
[05/17] KVM: selftests: Check VMPTRLD with active eVMCS
        https://github.com/kvm-x86/linux/commit/0d6e35f6ab7d
[06/17] KVM: selftests: Assert success in vmptrst(), kill off vmptrstz()
        https://github.com/kvm-x86/linux/commit/f1d4e357a695
[07/17] KVM: selftests: Always assert that vmxon() and prepare_for_vmx_operation() succeed
        https://github.com/kvm-x86/linux/commit/154b098cada9
[08/17] KVM: selftests: Always assert that vmclear() succeeds
        https://github.com/kvm-x86/linux/commit/5f73777a27b1
[09/17] KVM: selftests: Always assert that vmptrld() succeeds
        https://github.com/kvm-x86/linux/commit/9007b746aeb5
[10/17] KVM: selftests: Drop useless return code from load_vmcs()
        https://github.com/kvm-x86/linux/commit/f2bad303f403
[11/17] KVM: selftests: Add macros to handle simple VMX instructions
        https://github.com/kvm-x86/linux/commit/b2f44e713c6d
[12/17] KVM: selftests: Drop dead return code from evmcs_vmptrld() and load_evmcs()
        https://github.com/kvm-x86/linux/commit/776334470450
[13/17] KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
        https://github.com/kvm-x86/linux/commit/978c4df4b245
[14/17] KVM: selftests: Assert success in vmlaunch() and vmresume()
        https://github.com/kvm-x86/linux/commit/5adf7087cfd2
[15/17] KVM: selftests: Add __vmwrite() and use it when initializing optional fields.
        https://github.com/kvm-x86/linux/commit/68b94d08f9dc
[16/17] KVM: selftests: Always assert that vmwrite() succeeds
        https://github.com/kvm-x86/linux/commit/6ecd351628f3
[17/17] KVM: selftests: Always assert that vmreadz() succeeds
        https://github.com/kvm-x86/linux/commit/4e824a04d4fa

--
https://github.com/kvm-x86/linux/tree/next
