Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3F443C08
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975484; cv=none; b=lsGNQUG7JXpQcV1uHTauewAEzEcRbJI5lyrraLonUgJaxKEHEJVZpFnDsnKjWhwspa3j+NRvFPblCn+hYviHUKrLKZBTJGRJdrKCyISeVitsXcwstavO29j8IQn51isIyifQL7ZnlMcekxni+8kY7gq/K8pSupQY9LpbIJDIiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975484; c=relaxed/simple;
	bh=LfpTDpfPCAZ/vrJZLp/4w8pojzVWQcPuSBYnkto1BDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMMoPEEF28ylQR9/3p0cZSQw/ugVfdaKuPmP88a+EbCZQpCsfA6Y7R+VBrFwEwenP+SjcORb1wAKwA249v0BWOSGVbJ3Hb17cLu3rQ6oP+yBeBjzJe5XAGpFjbJ8zw2S1I+6NyjhkmOxlwUdo4Pm0c8ago2PO24i80i3/saSfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4k1bybz; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4k1bybz"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc435388657so23988a12.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975482; x=1791580282; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R80oPSF2c7nGw3U0Q3JrbKLXNgl6dyUbNUyGLhXLl04=;
        b=P4k1bybz2Ued48Uqhn2mgHNaMYhRQc+9f0Sbsav/nSwo+v+WryKYVMJhSgup+FAP1/
         dP/gRJzhH6z46oCpcy3tt/mKZVUoOIjKvi6DoMqJluWU7UQ0Z9giAG8TbtskwfgTAm4k
         nCU9QKVPDmVJqcNdxgRktySq9EIHM2uHS6EVVokFRIdcHt03c6cb7HDsWHQUIMF3e+bd
         Lhz3bZZl3j4ZiMfhR8m8NiJUX/fd1Gn/VvqKH6FEjT6ebeEM7Oj9ZryB1N9slRbqC7tA
         6mqENgsEz65hWXaFyCvUhTY1ukbsvxCIM89wzTw2AkMrpzjYQxK6Rjmc0UQ0tsxyX9aC
         iB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975482; x=1791580282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R80oPSF2c7nGw3U0Q3JrbKLXNgl6dyUbNUyGLhXLl04=;
        b=lXXiE1tV7gHbB7+Zn+5pUedjYsaVE+lu2L4s/XbmIDwycwI/122fHQP2Rqk/DuB0Hf
         7nAFRj6LIZxH/mgXcEODDvVE0FbUh1OLzzJjiUbxX8rkh8L6IKYy3d7AxJIPuzaw6TZV
         7OSDef3gjXO/Mk+zDkP8cCL44x2q8pQAp/KUsRpitpJ+LNO5soMHZ3ISCpCTyk+sAT2C
         uK+VCxkdCp8uB/OKCTUzgI414QUxo3BEWCrqqu2lW7cLb0zLNtMT0JNtp29kPZJl+iNo
         kpTRviJdoUo3IxL+tshT/J254MqI8ZcIfzWROk8+pklOX2oDWTBDDLWYqwVRqB+zZlp6
         v98g==
X-Gm-Message-State: AFuF++nSkrk9V48cXivsb/Veukhxxx8vyx+twbHLKf04xL8qGOUFZyEz
	cp2xNCFTT37nTRH6QzLsoPIudVkoKRpYrWpo/kko+aQaNW9NrcMc5LBHVcNoH7UMDI+0WNOpxOF
	RKLWPQQ==
X-Received: from pgbfe13.prod.google.com ([2002:a05:6a02:288d:b0:cc7:a371:1c93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1fc8:b0:3e0:af38:a4ca
 with SMTP id adf61e73a8af0-3e0bd018601mr3851373637.55.1790975482216; Fri, 02
 Oct 2026 14:11:22 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:30 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179096286516.3999462.7390107958093522927.b4-ty@b4>
Subject: Re: [PATCH v3 00/21] KVM: x86: Fix nested TSC scaling edge cases
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 30 Sep 2026 10:36:14 -0700, Sean Christopherson wrote:
> Amirmohammad's fix to saturate L2's TSC frequency when stacking scale up/down
> ratios across L1+L2 yields a final scaling ratio that can't be plugged into
> hardware.  The actual fix is functionally the same as v2, but I rewrote the
> comments and changelog to try and make them more approachable to KVM developers
> (AI has a habit of generating extremely verbose, "mathy" descriptions of bugs
> and fixes).
> 
> [...]

Applied to kvm-x86 selftests.  Yes, shoving KVM commits into the selftests
branch is awful, but the KVM changes are tiny in comparison, I don't want to
deal with the massive nVMX selftests conflicts, and this is at the very end of
the branch (I don't anticipate pulling anything else in at this point).

[01/21] KVM: x86: Saturate L2's TSC frequency if it exceeds hardware supports
        https://github.com/kvm-x86/linux/commit/b701a8139fd6
[02/21] KVM: SVM: Fallback to the default TSC ratio if KVM tries to use a bad multiplier
        https://github.com/kvm-x86/linux/commit/967e40fb1b08
[03/21] KVM: x86: Allow userspace to set KVM's max supported guest TSC frequency
        https://github.com/kvm-x86/linux/commit/95eaeb7f202b
[04/21] KVM: selftests: Use KVM's pRNG to randomize L1's TSC ratio in TSC scaling test
        https://github.com/kvm-x86/linux/commit/ed95a2725719
[05/21] KVM: selftests: Drop redundant VMWRITE of TSC_MULTIPLIER_HIGH
        https://github.com/kvm-x86/linux/commit/b955d8fdabfe
[06/21] KVM: selftests: Drop unnecessary use of PRIu64 in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/17919fe61684
[07/21] KVM: selftests: Randomize L2's scale factor in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/19d963ed9a40
[08/21] KVM: selftests: Rename TSC freq checkers in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/771902aecbb4
[09/21] KVM: selftests: Extract guts of nested TSC scaling test to helper function
        https://github.com/kvm-x86/linux/commit/6ab38c295d06
[10/21] KVM: selftests: Track L2 multiplier, not scale-up factor, in nested TSC test
        https://github.com/kvm-x86/linux/commit/ff18d56a08b2
[11/21] KVM: selftests: Print out the failing L{0,1,2} level in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/df1613249f6f
[12/21] KVM: selftests: Allow +/- 1 tolerance if expected TSC frequency is <100
        https://github.com/kvm-x86/linux/commit/faa4f010187c
[13/21] KVM: selftests: Use KVM's reported TSC KHz as L0's frequency (sanity checked)
        https://github.com/kvm-x86/linux/commit/43f58b1ee6fe
[14/21] KVM: selftests: Explicitly pass TSC frequencies to guts of TSC scaling test
        https://github.com/kvm-x86/linux/commit/b77a34ac9d8f
[15/21] KVM: selftests: Sanity check KVM's default TSC freq in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/6760d12380a4
[16/21] KVM: selftests: Test L1 "up" and L2 "down" in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/245932d3880c
[17/21] KVM: selftests: Verify that KVM saturates L2 TSC freq on {under,over}flow
        https://github.com/kvm-x86/linux/commit/c2d3a10b90b1
[18/21] KVM: selftests: Test non-zero TSC offset on SVM in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/baada72b9c01
[19/21] KVM: selftests: Randomize L2's TSC offset in the nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/5f13a511c782
[20/21] KVM: selftests: Use GUEST_SYNC2() in nested TSC scaling test
        https://github.com/kvm-x86/linux/commit/a744d1c1655d
[21/21] KVM: selftests: Spell out UCALL in nested TSC scaling test's enums
        https://github.com/kvm-x86/linux/commit/bef953c06980

--
https://github.com/kvm-x86/linux/tree/next
