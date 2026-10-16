Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5D3115B8
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115395; cv=none; b=NKCLjluZDcIyV97JtYA6Q8pD0vaB8tVEs0P3VZ7qEGQAFdbdK17Dj0PKlBFBih4YVViMg1B5xXSc3tegNhlFPFzh55jtW1vKQ859M8t6g9OjL+3MzbcErIkHPiBorKtqE4aYNew9yn5CsD1ou3sp863rwlMuxrnm436p36gU38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115395; c=relaxed/simple;
	bh=Eqwb9cwDQQev6ft8+cembLEHTPbJBIkKYvHZIrXXN5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BZmQ60UHSJryBvl5bKznLP/On6WiXEk8xsUHx0ysV3fyefUomox5vxC9WtouG4dCjF2AtMyndCxgFOKP6XeEmUSkxvs+8bJ2XJiF61euW6Dt82y4lZ0sn3sSmuxBsaa2zkwDlkdbvTctf5K9u9JaRvNE5zjjuDlaU9AghwonYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=my1JHfRW; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="my1JHfRW"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e93e2f72bfso36313955ad.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792115394; x=1792720194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ux01STCnGtDsKdixMlXVkH5njmEmFXWxx+GxqnnoxD4=;
        b=my1JHfRWj+EB8IK/26eLU+ZYBkHBj1DMvdVEUYurPj4bCJFC6XRB+E3xCFuXtjabgs
         VYZV71Q+cacQlRGib0n7l1cXSeQPRhwXQAZ8WxSXcgizr/hlPER4WvOcMuqgWJM7DG/5
         9nzHMECpV9wVI3SO0L/1dxwmJsqq8vKC14M6qQDnhyhqEF4M9tblppYbOqmFx5BbBAr/
         RVSH3S2sVTKqH8goHgwBoR3iFkDkszJFBnGflfll7kY30+QkP27CHQzwmbRRwnN16v07
         Jea9hen9Rhg0SqKHNDLBf5RP5LZtHRgswUu9pJF0cKE5i7yUTezuZpj4zpWtUbJmXh2Q
         8h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792115394; x=1792720194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ux01STCnGtDsKdixMlXVkH5njmEmFXWxx+GxqnnoxD4=;
        b=kWETuBLRt79SrJ5Wm7nE7Z7np9TN146mmTyK8ENY543ayC+3fKrcUm6qyZJepxfupH
         iGQn2Wab7kh5ebSlBp6+i9J3NWx05yb+b9LVpIBZ21I4HL8Xl/GrLCcchIZxsRfJ4zG/
         LfN9GcRQ1SVSjZgxfCdcslpvghB1ImCskcmlC8Utfqa3Qfpre/y7v3zGWaYo4/7Xr0V2
         5kkpzNR6NL2eMIyKhH26tYBqV3eoC/hxZoAP94wlajz2WsOoDexVC2j1sls8q0mu7qee
         Qg6qV+OrTcL/T9OsuPniXnuyL7UXJclo8EeEQU/0g/sjAI8GcBD+W+uzrOqd/YDJKdxr
         0lig==
X-Forwarded-Encrypted: i=1; AKwUvBzx8IVsPBLECNPkWRWcKm3kjTHFlfVD230vaoHAKZV3Au7za3MWSvfEq4VBlghGrORjH6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCmFPyK3J7jBnWP669YaAzrl/kYlMvsVNsYzSt6yL/16Y0pReA
	z4/zsHm1GAWxwgRklyvQ+V+cWdoSDGFqWHE58SAGjehFEy+mfD5i434PKgLfz7IlovCkcU17aBN
	eRNfJBg==
X-Received: from pglk7-n1.prod.google.com ([2002:a05:6a02:6b87:10b0:cc7:cb66:8df9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5681:b0:3e0:f4a9:3615
 with SMTP id adf61e73a8af0-3e16beb288dmr17279273637.54.1792115393764; Thu, 15
 Oct 2026 18:49:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:49:50 -0700
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <179211526968.809012.4905747914183363587.b4-ty@b4>
Subject: Re: [PATCH v7 0/8] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 06 Oct 2026 15:58:34 +0530, Ritesh Harjani (IBM) wrote:
> Patch v5 -> v7:
> ================
> (Suggestions from Sean):
> 1. Added kvm_is_ppc_pseries_lpar() helper in kvm_util.h to avoid sprinkling
>    multiple #ifdef __powerpc64__ checks.
> 2. Enable all tests via TEST_GEN_PROGS_COMMON for powerpc
> 3. Enable hardware_disable_test and skip when running on powerpc pseries LPAR
>    (nested).
> 4. Re-arranged the fixes in appropriate order.
> 
> [...]

Applied to kvm-x86 ppc_selftests.  I swapped the order of 5 and 6 so that there
wouldn't ever be a window where the kvm_create_max_vcpus test could fail on LPAR
setups.  I also massaged the shortlog+changelog for 7 and 8, to explicitly call
state the tests are being enabled (saying only "skip on LPAR" suggests the tests
were already enabled, which they were not).

[1/8] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
      https://github.com/kvm-x86/linux/commit/ab1d40006720
[2/8] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
      https://github.com/kvm-x86/linux/commit/f51639c0ee7a
[3/8] KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
      https://github.com/kvm-x86/linux/commit/2bc2c4a8105f
[4/8] KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
      https://github.com/kvm-x86/linux/commit/5527310b4d19
[5/8] KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
      https://github.com/kvm-x86/linux/commit/9de211597e81
[6/8] KVM: PPC: selftests: add support for powerpc
      https://github.com/kvm-x86/linux/commit/1b53b581d4e8
[7/8] KVM: selftests: Enable access tracking perf test for PPC (with LPAR clause)
      https://github.com/kvm-x86/linux/commit/e5983ef19a6a
[8/8] KVM: selftests: Enable hardware disable test PPC (without pSeries LPAR)
      https://github.com/kvm-x86/linux/commit/23140d6e54ac

--
https://github.com/kvm-x86/linux/tree/next
