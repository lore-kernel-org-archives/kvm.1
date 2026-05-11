Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E415319601
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514306; cv=none; b=M1ySzokIxJ7G7VLjIr903DM9d8gobNcGsFoPCBpceazX0CnklPCKvHis1UbuN37ZPj5/kpbpRvKRFBCG0LOx5Lodglsf8skm9/jmN0PuU5eKbg190jxcc08CFnDpts0TCIEUyC0EH36I7QX+GUt7asAZT0TEGEbhFVgY4ZSJboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514306; c=relaxed/simple;
	bh=iU2gjtj7qbeTkgu4CbWGG/n6OHB2sDsVv1qEvA+SQj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFXxIC7OM7Methca2VLASbdzesyPbkNXjn9tYi4CaavvpFygOaJoUo1yeqku58fXjBq+A92h19Tm7jqOalX6kK3bYBn1jpAZ9V7Kj9xW00UFffJsOzPDJrYXtXbuSQxG37ghV9OeAQxzijFC9f5K1n1Okd4R0Gy3XzDmmYrdDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx96AbU4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx96AbU4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c797d8c9c2dso5364225a12.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778514304; x=1779119104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quGxZdDzePyFN1sqDarFe9CnYNHrO/hP4QASdHelPT4=;
        b=Mx96AbU42KfmXQwcoagbaf/NvWrVoJQR4YbzP8yRJ07a9bv0GaGbcRMq3ZC6QWcQyb
         HHwnWb2rtFlrh2mrHj3akAantQQGiTbxyQvtigszO6QpdUsmm7D+S6KDlncKBymsI/Rq
         AOA9IpXf0pP+kmcNRpyIfSMFcp+2HwF/b9cr2Q5SnFLvZ7im7hWrNpSoxreGSVroo/Z3
         EoSDxurluc0RULGXe9NEezVNicx+BeRNN2ogAxCiU4omxy2eV9EYD7jHY+hxHZWUQB3h
         bO87r3f4G5TmzxjiLq1kvskoRBEExWo4sWKRn8V3kUyGogDYNWUQT3bgPrYubdyl/+Rb
         dwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514304; x=1779119104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quGxZdDzePyFN1sqDarFe9CnYNHrO/hP4QASdHelPT4=;
        b=aUoBAeyadpM7OEDLl0EkOb4gpYSePAc08SGKHTRZPbLiiUxvrrwiarQ5DQdB5omRRZ
         aJVdKcgFiYISPcRNUP+SWNtG7SrV7AQ0oOJAAdOIRPK1Aafugtq6ZK2W8jR4IpQ4XG56
         ocU4aSLdIpMMKgdjgfUI88Pvqtg9lYCC6b/K8AifOYv5P++n3YPDTiRtHrFYTn+Cv8C+
         DHSuJVrIzBShKDKIXOTWmCnC3wSxHDNqP1FsLhAtJljlGZu77UgVtwAHCcA4qyWrlj+7
         yt6ty9CpC8ddPyOokZeHWhaKP/7fnOm7khaZ1mxufW4vsN7chZD6cPa4/RIphrKtHcTN
         oXmw==
X-Gm-Message-State: AOJu0YybMuX/xHD+KFy4A8LyU5iogKEzoQbb440FS2Bd7romY1dCYSWp
	oAofjHxwIzjYY3MxxLCT5mhjK4cMtSCTJnzjCCKMrhUH+cdP+7/EFeRjPeNvb1NfDfIxZlZQP+S
	2Jdx4sg==
X-Received: from pfbg8.prod.google.com ([2002:a05:6a00:ae08:b0:83e:b5cc:11c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:729a:b0:3a3:a55f:407c
 with SMTP id adf61e73a8af0-3aa5a911f3cmr27765927637.16.1778514303443; Mon, 11
 May 2026 08:45:03 -0700 (PDT)
Date: Mon, 11 May 2026 08:45:02 -0700
In-Reply-To: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
Message-ID: <agH5fjWOfWO1L8u1@google.com>
Subject: Re: [PATCH v2 0/9] KVM: x86: Improve the handling of debug exceptions
 during instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 18, 2025, Hou Wenlong wrote:
> Hou Wenlong (9):
>   KVM: x86: Capture "struct x86_exception" in
>     inject_emulated_exception()
>   KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction
>     emulation
>   KVM: x86: Check guest debug in DR access instruction emulation
>   KVM: x86: Only check effective code breakpoint in emulation
>   KVM: x86: Consolidate KVM_GUESTDBG_SINGLESTEP check into the
>     kvm_inject_emulated_db()
>   KVM: x86: Move kvm_set_rflags() up before kvm_vcpu_do_singlestep()
>   KVM: VMX: Refresh 'PENDING_DBG_EXCEPTIONS.BS' bit during instruction
>     emulation
>   KVM: selftests: Verify guest debug DR7.GD checking during instruction
>     emulation
>   KVM: selftests: Verify 'BS' bit checking in pending debug exception
>     during VM entry
> 
>  arch/x86/include/asm/kvm-x86-ops.h            |   1 +
>  arch/x86/include/asm/kvm_host.h               |   1 +
>  arch/x86/kvm/emulate.c                        |  14 +--
>  arch/x86/kvm/kvm_emulate.h                    |   7 +-
>  arch/x86/kvm/vmx/main.c                       |   9 ++
>  arch/x86/kvm/vmx/vmx.c                        |  15 ++-
>  arch/x86/kvm/vmx/x86_ops.h                    |   1 +
>  arch/x86/kvm/x86.c                            | 116 ++++++++++--------
>  arch/x86/kvm/x86.h                            |   7 ++
>  .../selftests/kvm/include/x86/processor.h     |   3 +-
>  tools/testing/selftests/kvm/x86/debug_regs.c  |  72 ++++++++++-
>  11 files changed, 178 insertions(+), 68 deletions(-)

One goof and some nits on patch 3, but I'll fix them up when applying, i.e. no
need for a v3.  I'll probably also add some comments and elaborate on some of
the changelogs.
