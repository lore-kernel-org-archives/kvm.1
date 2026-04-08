Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72579187346
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607338; cv=none; b=g0HWF9y3I6HNMgSYv2KGbyNJTKs3fwNQ+5eOteS6Xh8x+QfQodw+wCwn0l9R4g5+Fl4JF37qpydSB6RF19L2wgEdxxk3GQLqhSGWn2juF8oUSK5GtoOQsCdsirHn9nE9FugWgTJGYqbl16lBxtN1otZKkwWYRgAuXAnsr4PGV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607338; c=relaxed/simple;
	bh=IO3jyP6uJtPh3KBU+q57zeJd3LHy+JhKKQSOMTDa0aU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HvckSL+gK4u6GByxUP6QlGPHG2bhO4mIR6uTmZyJ9cfxHlqIUFNxlY0xKqQnhtxNJbmQLUuK5k/fhMX99/3kYTta9TvLxMzYZwP0dvWAyspEqyGuFEZgvt/Vc6frqYc2h6BWIlUuT4Sb334E0EWWp4+udCHQc6wXVh5t6qN9rVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLxYQAxR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLxYQAxR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so3954501b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607337; x=1776212137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9BybqCgYyk1HVoZQ2mKhgNsFaENlS+bUgH/8dNDAGg=;
        b=TLxYQAxRfe5yntQPSy3yK7kJnXqwVKBsoIn4Ex6gHq6O5UhUxBln1kyvYCDhzzErU5
         aAB29ECd328ccB60dUeHxJ106MYdyb6Rjw7ogFVFLcKmJ535XCbW65J54X3ZBpf0tfS2
         BJChFEaOYJT07mDWJOBAPl3LbufJCvH6uGYYGXPT8hptsbBaoBwODoHfYLtW5kZ32pLE
         Zo5DVoNEvrJkfqgdIoNmePUWK2mhXknmY6gUUNWhuaJEmx/XbJs9hNc3F1m5rdNz3Xi/
         gbE/+9L1mIMWvbjqZhTPH2UL2wN3bKLHm9rgartzDKaeUPseBsHNaU3XQPVbkV1dCUTI
         xgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607337; x=1776212137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9BybqCgYyk1HVoZQ2mKhgNsFaENlS+bUgH/8dNDAGg=;
        b=MqqVKaR1mXbKEBDlwaXBVGGKq+xa4l2vWgIfimlm5ceJ6u8Z+iV5vVcPNDoBhLdCSN
         89CRA+b13Rwo2xwFLf+cUhjgmowvap/gNbfUOgxlcSk5bzWE4pAPYP5QbBPoRuDqrp3z
         vp08bA+tCrjJGLxg/Zl5A2ZXlwxXyXi9sD99lJRvLEWAgtjqZ6DHmo14OqgQ1VG5AP8H
         E+SwCq6nDNsULusNTU5iWLnXlSikhEjDbdA2WZfrUDkwNUvxpX6gvl8KGGSeYydefhtV
         vIvQ/xUqmtBSU6i13Oz8UCayHARrMnxeuaSNtjF/q+P1FCZE7DAERZMvZSq+gfWgF87J
         Jk6g==
X-Gm-Message-State: AOJu0YwA9Bn/eZ2s1k5o34O1VyGBdncBL8I7JGCi7EH5ydrX1v8LwSp9
	aNgmAQCJ2HBNfzxn0uXAjNyiMsnS9odIV2N77uDqxG70hXwI2R9P2nJxSX6GrRs7uu5qjOfak80
	GG3Qtzw==
X-Received: from pfaf9.prod.google.com ([2002:a05:6a00:a119:b0:82c:d86b:4a7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:238c:b0:829:924c:348a
 with SMTP id d2e1a72fcca58-82d0dbac84dmr18889391b3a.45.1775607336179; Tue, 07
 Apr 2026 17:15:36 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:14:40 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177560712732.1573391.728227401302821305.b4-ty@google.com>
Subject: Re: [PATCH 00/21] Fixes and lock cleanup+hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Mar 2026 16:48:08 -0700, Sean Christopherson wrote:
> Fix several fatal SEV bugs, then clean up the SEV+ APIs to either document
> that they are safe to query outside of kvm->lock, or to use lockdep-protected
> version.  The sev_mem_enc_register_region() goof is at least the second bug
> we've had related to checking for an SEV guest outside of kvm->lock, and in
> general it's nearly impossible to just "eyeball" the safety of KVM's usage.
> 
> I included Carlos' guard() cleanups here to avoid annoying conflicts (well,
> to solve them now instead of when applying).
> 
> [...]

Applied to kvm-x86 svm, even though it's very late in the cycle and this is
a chonker.  If there are any problems, I'll just omit this from the pull
request (it's been in -next for a few days, so /knock-wood it's all good...).

[01/21] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
        https://github.com/kvm-x86/linux/commit/25a642b6abc9
[02/21] KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypted vCPU
        https://github.com/kvm-x86/linux/commit/9b9f7962e3e8
[03/21] KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
        https://github.com/kvm-x86/linux/commit/b6408b6cec5d
[04/21] KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
        https://github.com/kvm-x86/linux/commit/624bf3440d72
[05/21] KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finish
        https://github.com/kvm-x86/linux/commit/88b16bf7bdc5
[06/21] KVM: SEV: Lock all vCPUs for the duration of SEV-ES VMSA synchronization
        https://github.com/kvm-x86/linux/commit/c9ebe8648ef7
[07/21] KVM: SEV: Provide vCPU-scoped accessors for detecting SEV+ guests
        https://github.com/kvm-x86/linux/commit/6d0d4cc7befc
[08/21] KVM: SEV: Add quad-underscore version of VM-scoped APIs to detect SEV+ guests
        https://github.com/kvm-x86/linux/commit/8e7172f2f799
[09/21] KVM: SEV: Document the SEV-ES check when querying SMM support as "safe"
        https://github.com/kvm-x86/linux/commit/4d61fc63ba87
[10/21] KVM: SEV: Move standard VM-scoped helpers to detect SEV+ guests to sev.c
        https://github.com/kvm-x86/linux/commit/3fae1e8e1fdf
[11/21] KVM: SEV: Move SEV-specific VM initialization to sev.c
        https://github.com/kvm-x86/linux/commit/18951f21c676
[12/21] KVM: SEV: WARN on unhandled VM type when initializing VM
        https://github.com/kvm-x86/linux/commit/61d7f912b344
[13/21] KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=y
        https://github.com/kvm-x86/linux/commit/332e201873c4
[14/21] KVM: SEV: Document that checking for SEV+ guests when reclaiming memory is "safe"
        https://github.com/kvm-x86/linux/commit/0689ee7ace6b
[15/21] KVM: SEV: Assert that kvm->lock is held when querying SEV+ support
        https://github.com/kvm-x86/linux/commit/c34c81e08d7f
[16/21] KVM: SEV: use mutex guard in snp_launch_update()
        https://github.com/kvm-x86/linux/commit/b69560d32aa8
[17/21] KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
        https://github.com/kvm-x86/linux/commit/fa4e5564204f
[18/21] KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
        https://github.com/kvm-x86/linux/commit/ec6d08c5a71c
[19/21] KVM: SEV: use mutex guard in snp_handle_guest_req()
        https://github.com/kvm-x86/linux/commit/612b2ce45d98
[20/21] KVM: SVM: Move lock-protected allocation of SEV ASID into a separate helper
        https://github.com/kvm-x86/linux/commit/af0cd8d7f455
[21/21] KVM: SEV: Goto an existing error label if charging misc_cg for an ASID fails
        https://github.com/kvm-x86/linux/commit/11acc5d0cfb7

--
https://github.com/kvm-x86/linux/tree/next
