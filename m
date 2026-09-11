Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34901309EE2
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088438; cv=pass; b=GwkBQkypqlAPheyPh5f+R+FYDf2L+z9DitFfdkiVgbENGkF00idhFtQh47WAUHqORyue12e80taWr+VhErPtpbDf4a6TsFVc107nipNfZE6ucTe2rPtSNE1ErUrWBcL6T4uVPFR9g5S/j6tbnGnJz0g8wKDerJ6zN4WOGhhSXg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088438; c=relaxed/simple;
	bh=cm3sMjj6dg/Ij/Ch1aHvmiK0QfwA6u8gf3sSA0DKTl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fhx4XUXlkaLLIaWyjJwaLx4RHWbEh8BD/KBRxWnX/uPBFFWvgW6CjZzheb7KqPsFuf7ZCWDqr5MZwIayMyWU/xPYebc+fntiPpXQk8Blgu5Bh+iNXEDlbbyHX/Zf12AriOfxxpB9tLb1sJrnBiLhONIPLQIDcMf4y83QJLReYWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAQZBrs2; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAQZBrs2"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so2534a12.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 18:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789088434; cv=none;
        d=google.com; s=arc-20260327;
        b=W3CLc3ki3tarbGEgdjnBibYOk9tuDoWUsEtc3P//wKKCAXTVUqO0Ivb5ZKls/tl/LW
         Jr2vktq8mC4IDS7I4Su8Dq+XK7TT6++yPpto3TkgG+j8/OlmGLCPzVd54XoJSk2+z4DQ
         57BsrfgZ3zNz4eYl8boO9AKt211G8MC44ewn6U0vL5qjGc0u1mMrrOYWWJRLEy9ScnMj
         ExKBLLVMYxU0TaDh+r5e1A/vfbEr3P4lTWw5RT7n50OJK5ie0YTyLU9SEKkGktJxaAmo
         iDY4pEXU/VAeyw/A7z204b5OkilkNH2OnIbpMG+CBqYV1AjuZvrskD+Yo342FPHklppr
         QbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9W7wf5Z1q//5NgqTWb191yrPA1yIRBuapqyaZSNqGrQ=;
        fh=Abo8uKLJ8J6lKjD1gBhlYyI+5yOQwR8KX6webTH39gc=;
        b=o/wJgWAKRQSvdpXXiIb4L4Ny/Xb1UWj6AQBPfmkVofWnCbwvkAklIo+YJt/d2vCk0c
         OHkx365u/BpuMFQC3aAXa1iowFYkd0YeMVAP5zSs0z43sUa26YXyVN1sZ68pt6UKW0E1
         bP/Qh00QfIU9MQPq1ByYmvN3GGza+POUsSgPsgvl44f1BQvbTHQdhcHQ0KlnjBHjtYJk
         pFStVRZQNqT+Uuqfbtyr1CcWXqggEGL2Ao+XAwlLgdJxOYzGMYuWBAqFLNqqztKk/IPq
         1i51FXoSjvI1yB6x7Lx2mPEixh4Ge2JWvj9ZERSGFc4AM5iq1++bUpB2CeWaRFoEeC0t
         J2lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789088434; x=1789693234; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9W7wf5Z1q//5NgqTWb191yrPA1yIRBuapqyaZSNqGrQ=;
        b=EAQZBrs2VaqQJSisxlmkVHMKRYElEl5yzM24IdKWNVa0bgLBpIqAAvMvRcYZfb49oz
         hOVjJwiQBGt9t3fDm6+n9s4Grw3HSuoj2XlElWit2RviCG6ReYcPu898/zbIOlE9o1nC
         EOaDrb+DgJGIWh0j2CzTpS86JcCyjdvb/4BP+/IoBqsMAqR8kExZxASMJ+AlwqQGfMJ5
         nvqT6VJIwwcdsNUG6QsM0/4I6S2i3gujCdfJweNwSDz6EjMnhG+mLnrdq9rHzJyS5NPb
         1r3rT/2vDE7CpC9n2mD4+RSPrGjlhNB35EBYf1KTzSVD1vsd2sYMO6gmUyj5RaRCc2T3
         K9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789088434; x=1789693234;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9W7wf5Z1q//5NgqTWb191yrPA1yIRBuapqyaZSNqGrQ=;
        b=Y+UNNyMz61uI3zWWan8iC3XVd/ObK5pqf4fNOOwzynxbYQ/LDDSa2wJRs3/Op5SaHr
         pk4K62omehz4N/7IBFc5vDzqckYod4J72FAymx1kvbrwHDZ0pEgK/Q7nOC6UVLjHCnbL
         Tn+mwT+je5Fgy8FBesGuyzp+42ocLTkRg9SFyFOvbFmFmm6cFFTmlID4pcVG2pHnzEbT
         bFBo6eJx4O5xoclvhqrMbBcShLZvJSxXKuXGmEYEYEMNmHaOWhTBAApIzlStUsglPcw1
         69kf9dr9enVGsQSSP6bSzXV8UOL+EfluTcJVf2df8djJu/CEGg8Nukyatp8rkLm9C2pr
         dBxg==
X-Gm-Message-State: AFuF++mr3nc1Crw7P4bwvgq6PEWDWgmcINdGKihoWSjfs/MEDZHmeV/F
	Ubr/bIkJFiTyiw6RzaAUFSSSNfzyLiC2b2WGuvyqe2YteWyl7c2o1+4G5wuF6WLpg+8o9TCFRwr
	0dr/oRcYqoujVJPSb3M6Ggud7MKXWaRcxkpx58zw=
X-Gm-Gg: AYBFou2KdkNadS/y2gZ3x4KFP8WgYW7Z8tneYg3xFwPdseyz7J3PBhj/QUSyWM6qGqT
	ilOG3jL7x/+FvMRfOAD+x0Re/cUrbnO4TOqTOT/tWp9hUdPPWBPvpTziHqjuVFFIPmz/SkwLQJG
	AL1bJoZE3ohBwk68syaT21ZEWyXvm+MLpr+GT4CTXPmYycpvVdOmfxg+t1fzlm1XUtAl2XDILB9
	N2fzGlc20Z34yhrr9ls9znDRz9t4CAw2I6+hstQj4i74lrC0qWiUHaFINTg1TGJl4Yd/2Quh+lg
	LQ0vc70a9ZINhAwjJrXeSPPefAEigSPy0tgqMUtQdZxJ3rGCdabeBiDQ7OLACkR0o3SnG5DwOhP
	rOG9ImTcNXOg=
X-Received: by 2002:a05:6402:424d:20b0:6a4:abe:b08c with SMTP id
 4fb4d7f45d1cf-6a9b57cb410mr21122a12.12.1789088433597; Thu, 10 Sep 2026
 18:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com> <aqM0RIiLVqvwit-w@google.com>
In-Reply-To: <aqM0RIiLVqvwit-w@google.com>
From: Jacky Li <jackyli@google.com>
Date: Thu, 10 Sep 2026 18:00:22 -0700
X-Gm-Features: AcwNN1XUgXbbn5nwS_6gLkiHnK1ioVC0BuqHuY5_oGbYdwxTTcUgR_nTxyMVzt8
Message-ID: <CAJxe5cuFaodQLcKvSTytobb8hszH+YhPpvoQ14SWQpqh-2986Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 10, 2026, Sean Christopherson wrote:
> When stating what a patch does (or doesn't) do, phrase everything as commands.
> Passively describing the patch, as done above, is problematic as it's not clear
> if the changelog is talking about what the patch itself is (not) doing, or if
> it's talking about the side effects of the changes.  Whereas this:
>
>   Don't try to validate guest-provide ahead of time, as such checks are prone
>   to TOCTOU races, e.g. with Page State Changes, memslot updates, etc.
>
> is more obviously talking about the patch.

Will do, thanks!  I'll use your wording in v2, with s/guest-provide/
guest-provided buffers/ and reflowed to fit two lines:

  Don't try to validate guest-provided buffers ahead of time, as such checks
  are prone to TOCTOU races (e.g. with Page State Changes, memslot updates).

> I don't love that userspace VMM goofs will bleed into the guest, but on the other
> hand, KVM already uses this pattern for Hyper-V hypercalls (and worse patterns
> for KVM-defined PV features), and practically speaking this is better behavior
> than returning -EIO.  So I'm good with this.

Agreed, it's not ideal, but KVM can't distinguish a bogus guest GPA from a
VMM goof for now, and killing the VM is worse for the former.
