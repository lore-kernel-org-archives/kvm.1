Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBC4E1C73
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730685; cv=pass; b=E2dfXmRO+5rpmN2k0gp2T7HKflNotZ2ltMW5f2eBXLw1+/i0J5UFdjkvrG75N3bFshjuSiTBZUdmo+iqSzI6kLSUUtwlK7EdJX5yE8c25JS6Gzi71BSFeArf9sAPhGS9z9y4GGf6Lz2/kdCJ0WNrg12PKnliWP6LRAxK7CF7Ywk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730685; c=relaxed/simple;
	bh=uBnC6KA4mFvaE05vQovsBFoi0Ky2dT/n6cHsROU3IVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Flk/Vr8GV+dit33NWPqjIa1nbFpnsPUuSBvOjvJZJpGOwU/Eh7/0EEoOrKslY7aNGkEWGJrpfA9M3ScJTcf2jLkQpMskGqrDM04P22jnHAZVyIhvgp0UX+byFPrkx9AxRR9exM4mx+xqjL54kCJfW+1O6kjCF4YcikWHNlABoMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2Q+F0lQ; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2Q+F0lQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so6564a12.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789730680; cv=none;
        d=google.com; s=arc-20260327;
        b=EjHorG40mKJ5ZDJF8auj1TnDXwdNSsQubIUIc0ESgU3RFG9nznW6F2vUdaOhJRm7kG
         iGqOOmrcA2cCjGnoHRgCq2wj5MYOjj6WeeYzLHy9+syMyOLB+5kqBxixLIws13nsn8Mv
         HeAt2QeRAWTkf4JmSgoN9J4l4m+74FOK6O428S+pDLE3reabLzbILeIWCrvCZxV4HSfi
         Zy4LAiILg/Oroqrm2pQloCmA1rnZVSodDMxXDvX5Hltye/PlVDj78CPe/Cn94cZiGr0a
         5JcBys8k1V6UWJl7WCO0/cOAGbYfS31VNud8ZzmZ+mGofh5casc6jCn1uPokWNLp80rs
         ghAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7a5izxf6YFzXYW8w93EbliwqXIbZagpn1chA3AffJ0A=;
        fh=/8pwEDZpSN4KGjs39IISAy0H41rEaWaHw87DydQ7BYU=;
        b=CX2iGzVTKSs3i85FUreaHNFlUN0vqTQklkWjxB5hSu28hLpq9/8b9fhbKqejiE/ruE
         DhIu0a1DB3T77wFyTh7dJtBSsOvMKzl3oEU54mXCxUo3yvw2NZj90mUimY2o2JolY2/o
         m0n+bevp0qS4b5JT512VMrAMF2LMYcE1xC+0CrOGQNdLKNv906autR1BEofi0h4vCvLh
         2pwUMExL5rWF+QWfS3bkQPjdO1oJ1DTrBwChjLhgwDVKYphbk19n7WVX3NYS1lXEvH40
         IDZ9XE7+t5/G089tlr4UYggRQoo39Fx5dsDqCw6Q+TgWkyxCHD0Xc4C5KrOJk3ZJI9py
         fHlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789730680; x=1790335480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7a5izxf6YFzXYW8w93EbliwqXIbZagpn1chA3AffJ0A=;
        b=o2Q+F0lQUDOlildXI8CHt2tuRsVMh7RNL6NsE6gE7zgjPqAmIzvxc3mMaTj7iDJ4qi
         6Kp5a+pysfw40TIAlsZxZ81qAnHe9p8jcGmZhafR0URdMZeNWtJYjbEbv//VBmstq34Q
         cfFA+Z6vWvYXnpxPRiUztO6W7pQkJNT03gsbajeaTvTpSaumUYEplNxArRaBRur4ET4t
         35KT5FLGfSJx4qY8TCU2307Bp7bLztGVwTz31oNj+uPnnDVu69waNHuBvI+0TjgYLWxS
         3/C0xDli/wxKsDyCRJwF6coH7erjAVcivNN+Ztq0SCj29zTatEaDVCFSxmaayPOdWsL5
         LUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789730680; x=1790335480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7a5izxf6YFzXYW8w93EbliwqXIbZagpn1chA3AffJ0A=;
        b=sPkBHUyEB5JmMhMIjQvYbxVnqm+r4nK0RRvr2j5xXGlgT+LU/89HN3cq41nOjvRKKt
         0RU7331bZYGc0Z0GUSik2rILHj3vvWJ38x4W+eRfdFSxhCZIZasYvheIPkjpyWwhQlpU
         7oKSDKIfF5gH497GtIB0bE/33KOD9tl/4frR+GOZaJZOcX6nwy7swc6OOMgMas1mj60Y
         rLHfFM4ZslUpU3esLoqXwdvFJV6NEtw5/tDSC31js/wm/OIB5bQcVfrtD5pl4r6Uvqdm
         5E/zlYK0LAjPtBuxvKk/lvRhV8+6o/m/SgmbgJWTb7w+zrZ4kTYHyUVuQ1ngUIVMfpDq
         TYZA==
X-Forwarded-Encrypted: i=1; AKwUvBw/+HFsJLk4MIpgFzWQw2c4ItUphKyXtSTyVjhZiQLS/MiSrzW0asyU6wEc3eUHWqbZXtI=@vger.kernel.org
X-Gm-Message-State: AFuF++l7uShjUykGxHvEJjSxU1yarmp2HT8RU5l67o15q5SgvaVLmGQ1
	e7PD3Jgu5uUQTAt32L7ZQD1rhuv6gJvbV1BMk2ThhgG2rRRRu4vi9zUIpZCtUYVbZYunwJ7z/96
	Gor5zN80S2hSqKhSvNL71uEvG8uBalo8XBt5yM43D
X-Gm-Gg: AYBFou2DQ+doYQnJTEOoC+mzJVzZXTf6Cil97Is2KHnijJnFX3OI2OBjtSPl9GANfUh
	DzDsaSIfNiCdyrolqv+hcZqcrZFiIjcZgTUjJIXcfZP6ZEDurAZ8RUzBsBY9oMqndck+sZOHN+G
	ptRQ2yTMvFdUz/HJFspa+52ZRbYtG/uskjoAoWKpyiMUu1PhjXRSA70Fl8wBltStd8WcYgPFwCD
	pPv7qWfHzEHNzKpRxvkizn6X960jbHZB220TcoxPL21JSW6mAit7PnkDjPjbYgP+sy6Ae0VGndT
	14HHCgeeVJ4cwVZkV5ugpgbp/Dul4zileT5tmaacgY5vP9SHsQ13clss
X-Received: by 2002:a05:6402:3c7:b0:6a6:967c:3186 with SMTP id
 4fb4d7f45d1cf-6aa4df21b4amr30464a12.2.1789730679801; Fri, 18 Sep 2026
 04:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789721173.git.zhang_wei@open-hieco.net> <1355f32599087e8f4d0740bb92ab5f0c9c329b6f.1789721173.git.zhang_wei@open-hieco.net>
In-Reply-To: <1355f32599087e8f4d0740bb92ab5f0c9c329b6f.1789721173.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 18 Sep 2026 04:24:27 -0700
X-Gm-Features: AcwNN1WGefe8mq1Aq8R2hXSQ4KSfm5bPolxygvJQEfdVJUvpg92P3z4X6vU4uvI
Message-ID: <CALMp9eTM3WN7idYYK3hhkuYgdDbwE94VTZB4F0fj33DTa1ExuQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] KVM: selftests: Add nested SVM DecodeAssists test
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> Add a focused nested SVM selftest for DecodeAssists.  Verify that KVM
> exposes the feature to L1 and provides EXITINFO for representative
> MOV CR/DR, CLTS, INTn, INVLPG, and INVLPGA intercepts, including a
> MOV-to-CR0 selective intercept.  Check hardware and forced-emulation
> paths against the same expected values.  Poison the instruction-byte
> fields before each instruction-intercept test and verify that the byte
> count is cleared on exit.
>
> Exercise instruction bytes for hardware and synthesized #NPF/#PF exits.
> Cover a synthesized #NPF that follows a hardware #NPF in the same emulate=
d
> instruction, an unreadable instruction tail that leaves only the cached
> opcode, and the absence of bytes for an instruction-fetch #PF.  Modify th=
e
> MOVSB opcode while its MMIO read is pending to verify that the emulator's
> cached bytes are preserved.
>
> Inject a userspace #PF while an MMIO read is pending.  Verify that after
> MMIO completion, L1 receives instruction bytes from the current RIP,
> not the previous instruction's emulator cache.
>
> The hardware instruction-intercept, synthesized OUTSB #NPF, and
> userspace-injected #PF cases run by default.  The forced-emulation #PF
> and instruction-intercept paths require kvm.force_emulation_prefix=3D1.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@google.com>
