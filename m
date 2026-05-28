Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74D3F8EB7
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990463; cv=none; b=eC6mTw2BSUF1vVpAdbEEjh1eJbcneEkUCiKvSeZVnVlDA8Px/bc6bs3NR5ZRxeKxqP92yIPvHYsxYIt+PvRUeCZ26frHc6m4ZC/bqEu18kwpdfgwUEreD9/B5W04+HGw+amjp6yuFgiyjuCLfmVPGG3xd7gsreXcWbnSbEdyz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990463; c=relaxed/simple;
	bh=jBGgNigAjD8TM9vgay0XFguhyKOsgwV51l6+9yE9Its=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX1ECg2BNKBT9vcXEeu8cesd+g9YSKs5vgEASZt1nVreMX8HUsJtmpnWKJGVHJD61xkM7bZWv8mXY6qA6msbTVk6u5hP0uRGiEpFQcK0eZtDBgvrVvormcNBfzrBTHaPFmZccPw70ULCl+eVPN7lYRN8XaHHWZaxplX+F6C/Ves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdBPMP2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdBPMP2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACF31F00A3D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779990458;
	bh=cfS/5MsnGQC1dO6o37juK5Pyit++kjneswp//vBHqn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cdBPMP2VRMHc1zGxTeSrJGzM1eFWiZx1WXvpwPGF9HTS7AR1tueVfmJbln2KADJ8Z
	 npi3WrTbsWwXvgumn/0atNHsmHqsCaXHSujkDf6rkHmL8wBuadhmUNTQRRAWt3MKvm
	 1EhEnIGvkubGL3l2rNdQlOCTDwoa8LKGD7/zCPrGzbfaevjnGNEdTQOIRYjHHl9LVS
	 Z5onMcULi3aECLQX6sMZVY7P9o1Z0ph3MQ/NsrisTyrugx22PBKALhmBl2ybqjsMdz
	 1EqcdWjAXgB6eA/kcNw6gaqmQYAKdyAh1ZfRAYPn4eCl7JoGyYvFRKVyrArit1fOgJ
	 +rpJOMJv12xxw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68bd167797dso224306a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:47:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MM1JLsI6+iwbkUH2kOkYFvSX4a2gg79JsqRQA85sbF656F6qwDvSpNGmbUG33NJ2GVJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQwTmD5IEiCy/WeOloUK18a75IpVO33Nf4u+JE0Xx4Kakg3c5
	Bhh0dSYrTqnydt99TVkuwx3ZiKJWkKNWIM/xKAkzaS+lY+NZ43sDApziKcI3e67vyDDkB/AWl+t
	XY6bs3HXr2uE9C48a9AFiAD0sRWpT/OM=
X-Received: by 2002:a17:906:4fca:b0:bd5:7a3:a591 with SMTP id
 a640c23a62f3a-be974b10cf7mr9610466b.48.1779990457847; Thu, 28 May 2026
 10:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521175948.522757-1-yosry@kernel.org> <aheT_AUgWYJxZJlR@google.com>
In-Reply-To: <aheT_AUgWYJxZJlR@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 10:47:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM5YDdGY0nJ6E_0OFtiTosPG7owhSEZ-cd9hRJvaPagSw@mail.gmail.com>
X-Gm-Features: AVHnY4IdLUOmWokuSvM0ztsWO2ws2sNxrYricaL2uH5FFnszW3RSEKNwQJoX4Fs
Message-ID: <CAO9r8zM5YDdGY0nJ6E_0OFtiTosPG7owhSEZ-cd9hRJvaPagSw@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +             case UCALL_SYNC:
> > +                     if (do_save_restore) {
> > +                             pr_info("  Save/restore at sync point %ld\n",
> > +                                     uc.args[1]);
>
> Meh, this is noise to me.  Maybe it's marginally useful if there's a failure, but
> I don't see how it can possibly provide enough information to have to avoid
> hacking on the test.

I kept the logging in the test mostly as-is from the original patch, I
don't have a preference.

[..]
> > +             case UCALL_DONE:
> > +                     pr_info("  PASSED\n");
>
> This is useless and noisy.  The test runs in ~.25 seconds, and most of that is
> the printks.  If there's a failure, I'll see.  Otherwise it's a pretty safe
> assumption the test passed.

Same here.

[..]
> > +#define NPT_DISABLED 0
> > +#define NPT_ENABLED 1
> > +
> > +#define NO_SAVE_RESTORE 0
> > +#define DO_SAVE_RESTORE 1
>
> Eww.

I can't say that didn't hurt.

>
> > +
> > +#define NESTED_PAT_TEST(test_name, guest_code, npt, sr, iter)        \
> > +({                                                           \
>
> Unless you need to "return" a value, do-while (0) is preferred over ({}).  There's
> a technical reason, but I can't remember it off the top of my head.

Yeah I also couldn't remember it so I convinced myself that older
compilers just couldn't handle ({}).

Looking at https://kernelnewbies.org/FAQ/DoWhile0, the last section
seems to corroborate my story?

>
> > +     npt_enabled = npt;                                      \
> > +     nr_iterations = iter;                                   \
> > +     run_test(test_name, guest_code, sr);                    \
>
> LOL, all of this, and the one thing that _doesn't_ use macro shenanigans is
> string concatenation.
>
> > +})
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
> > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > +     TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > +                  KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > +
> > +     NESTED_PAT_TEST("Invalid gPAT", l1_guest_code_invalid_gpat,
> > +                     NPT_ENABLED, NO_SAVE_RESTORE, 1);
> > +
> > +     NESTED_PAT_TEST("Nested NPT disabled", l1_guest_code,
> > +                     NPT_DISABLED, NO_SAVE_RESTORE, 1);
> > +
> > +     NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
> > +                     NPT_ENABLED, NO_SAVE_RESTORE, 1);
> > +
> > +     NESTED_PAT_TEST("Save/Restore", l1_guest_code,
> > +                     NPT_ENABLED, DO_SAVE_RESTORE, 1);
> > +
> > +     NESTED_PAT_TEST("Multiple VM-Entries", l1_guest_code,
> > +                     NPT_ENABLED, NO_SAVE_RESTORE, 10);
>
> I appreciated trying to avoid true/false literals, but this is harder to read.
> At least "true" and "false" are visually different, {N,D}O_SAVE_RESTORE are one
> char, and NPT_{DIS,EN}ABLED are two.

That's fair.

>
> And explicitly defining the number of iterations and whether or not to do save/restore
> is silly.  It requires _more_ code to provide _less_ coverage.  Just run the combos
> for npt_enabled=false.

Also fair.

>
> If we're going to use macro shenanigans, let's actually use them!  I've got this
> working, I'll post a v4.
>
> #define gpat_test(test_name, guest_code, npt_input)                     \
> do {                                                                    \
>         npt_input;                                                      \

Oh I like this very much. Passing in "npt = true" or "npt = false" is
great. I wouldn't call it npt_input (maybe npt_setting or sth), but
that doesn't matter much.

>                                                                         \
>         pr_info("Testing: " test_name "\n");                            \
>         run_test(guest_code, false, 1);                                 \
>                                                                         \
>         if (guest_code == l1_guest_code) {                              \

I thought about doing this, but I was worried about it breaking if we
add more L1 guest code functions. In retrospect that was too paranoid
(as usual).

>                 pr_info("Testing: " test_name " Save/Restore\n");       \
>                 run_test(guest_code, true, 1);                          \
>                                                                         \
>                 pr_info("Testing: " test_name " Multiple VMRUNs\n");    \
>                 run_test(guest_code, false, 10);                        \
>         }                                                               \
> } while (0)
>
> int main(int argc, char *argv[])
> {
>         TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
>         TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
>         TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
>                      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
>
>         gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
>         gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
>         gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);

Overall looks great, thanks Sean.
