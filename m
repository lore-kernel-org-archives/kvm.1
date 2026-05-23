Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30272202963
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496843; cv=pass; b=HggUJM2wXhYby0cJZ6JbJOQO5NAmriHDBx8Yk7HQ3od/ReUzN1TmRg21sgFWl1Uojjgws5JAULBduSCZNB2XccIiX8xpXFUP72o4UbMIahj6+RJQCpVqKqRh/mNm1eRcSAj8WpWk8pqI9MVaHU1Mi4a3MEUsAGQq6hqX0JP0faU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496843; c=relaxed/simple;
	bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JMpDN5u6KebJq0d0f4W+iWP/5JnBXr71+AXfRjdC1OcQRWDB6yhw3msfx3Uz9kVFfu57aWg+CyUU0QF2gVh4I+6+brH++11Prh3UPNUbvJuuWckjfrTyMJgx2Xn1EZyWYKWwWNIOl2/U1bpWINRzHL90YrMVqTuoZ3G7RARmV8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIMpXNCH; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIMpXNCH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd85ebb368fso1163641166b.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779496838; cv=none;
        d=google.com; s=arc-20240605;
        b=FfDvIWMjqjzit6jiob0eEXSjTPZUsfjVlz8+o5fcDAsJtdF6atMGdqaZO5Y/W/bFwc
         AnUuPfUMKw3zw8kHjIPXkCb7TXTsu4YO15KjP22khqIdMYkzm/Qvprn8fVBp+Ww+k+QX
         35zMvW79mvlX7+HjMdW6c0RptkX96UFpRI8lLombYIQXdQvTQqNZfXmN37G8pEmoqg5A
         XWyALgwtm7Jdf8HysynEFPQA4Q6Yvf3KQaUbiah1lTSjF1K0a/2x3x0f73D102nla4Ts
         NRcfKMOPtpw+wuvKtFy4UxA/0jr5DJ/Jl5mrKy5xKL8FLrH2kgZrbp7ihbakG+kX9dDF
         YdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        fh=HJlfduJAlgPb/orNemJiVkr14I71kVVTlf0uB1+rjKM=;
        b=EYSCm8JiR2nanl50cLl0LgP743ljiJ3+w795znu67Iwd9pOKpg4KTboUT16uKrRF2O
         ny9Yoabkq1AVwOptY86hOWzcuaIOEDJB2LTFyeKl9SV8edw5vuVG6Rq0Ydwf5J0GASxI
         IGODAXy+UkKLcHs2Ns5dicZ/cyTKUhg1dzH9+BboFac6c9ACOGS8PJroTZLibPGdSQUV
         qgjs68uBDN4JnqxPgK1u0e3t05jBDp8Rz7Xgp8N3A0Y/l5qWDsXeNeFzODrfT43nVkSy
         ITn0Rw7oLK6XiVtnKav5YASPX6fJxBQ7GjUfPHjcWi/4IXju1G4xEPn0uQBU9vjmz//b
         KZ7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496837; x=1780101637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        b=bIMpXNCHxQK0qeDM/HE5qa1FoK4ujNYSgSghrulReXq0Xa3e9sJgwn7K0AIGFeWJpB
         m8EmEKUZX4eCFlyAvkYLTsB19S3LpBF1Bi+8PjCHhoM4kDNA6i3h2TPhsexang+qMugU
         2JCNlbvYvGO24kZSnCrsrTHIJfD+MUoCdYEmeO2O41Xh5o0+9gJtY1QZxJklZokkCcXR
         PAYd8wPNdEPLdVRcpJGygWr2VDC1SaozJyJwuRxUyKwYJkP+98gNBAeEr2GCY4vQOHO6
         ZLvnfpuupfMYmx3PEw6vANE2oMCXW7VXkWisB68Tt2FcR+iqwGbMsyhIyvFhY4txjAqB
         29OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496838; x=1780101638;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzImTxEIdLT7uoHzI85KHDAQ5RrAcxR1yc9QoxOoDBU=;
        b=kJzH5tTqE5/WET8Km3TIa/vXgqnJC48jD39fVQlm6cw0dBUUZ+7GwJKizTkLNFc4Vj
         NcMTKfLY2Fp7erIKN0PHzXAUI+5jIAYIX7Hr2FrilNWbhj1slj7IKou4e02+ShTGks6t
         1GD5HW4n5r5Ud7X/XPjRT0pAuTwPBv3hq7twimKThhmrIHfsbege2xS51PMufU5XmPLM
         J3bFly1haT80hi2qdPiFg5RdCkkwHisGNlKridwdj9JLnygb1feOHBKOvov3HjwSLOYG
         WuNzXXfufAveTx26N4szIiUE+FpqHaRkzRFXgM53fL0ykxYezbbZfYYKhYeCt14aFb9Y
         y3Xg==
X-Forwarded-Encrypted: i=1; AFNElJ817NtjsoS6DyUPPS6wqXZWApfCviEdhb1lRJ+cDenMPpTTL309tmNpfXDW2n7BvveM9LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXb9idRK8lHUjRvI9N4y3cjYU7moOd488ziEZmoUkVt+nL8ar
	of7rt+iSrr9yD6+WHfB8k52OWD9XILVMIHhwzdjbRIFVnjV4wqxQrnty26/VEEDrfLeLZgGuwcF
	mAjHeEOSjzLF+NaRJJjsLO3WJgAlCnBs=
X-Gm-Gg: Acq92OGV1+m0NzDP4KjQfcHoR4ohYPDlqVS4ZSWkBQ2pw9pN/4hjCff3pVdoi6teVuG
	iE8tS9PdI/6F27a3XhztYi3QlBFAyLIqzHR8zSumiEFaN7RWRGKn/Q/P5iGq7DhsQWdG+DZzjrv
	2gnQLrybTshdkXEYbxh1/Rlkg4pSSw7IAEmvgE7czTNm0TJAerG8n0eSaC7EUPqSx0IBD6ry8JS
	x6iZrEbz3ZJAQpurZFC0ZgdotYIKUpuMzvfQhEwiccXltVlw1s3YsLKkYw2iwVdIQMsGZU7e6F7
	4mMjCxI6ykiKhYD2WErFntcc3cs8Ser5NOHU/3Y0fhmR9rj0uQ==
X-Received: by 2002:a17:907:1dec:b0:bdc:fafe:bf66 with SMTP id
 a640c23a62f3a-bdd263c9230mr293031666b.33.1779496837246; Fri, 22 May 2026
 17:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 22 May 2026 17:40:25 -0700
X-Gm-Features: AVHnY4KUuDYdbAhs4DxPRoruchoX4HF4FN4Q5Flh4ze1fOCs2dB2rccyA0BbHhQ
Message-ID: <CAKSQd8WP4sue4Pzf3yK67iMUkPth2xG1CrpUko__JF80i39=ZQ@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "clopez@suse.de" <clopez@suse.de>, 
	"x86@kernel.org" <x86@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, May 12, 2026 at 03:14:54PM -0700, Dave Hansen wrote:
> CPUID (the instruction) is defined to fill in eax/ebx/ecx/edx.

In the original x64 spec CPUID inherited 32-bit op size from
the pre-x64 days, and although established leaves might all
have followed that definition, the ISA per se doesn't prohibit
an implementation that allows, or defaults to, 64-bit op size.

Having made that statement... the same does go for MSRs.

> Those are 32-bit registers so the normal register rules apply:
> "32-bit operands generate a 32-bit result, zero-extended to a
> 64-bit result in the destination general-purpose register."

...in PM64 ...while outside PM64 and across mode switches
the upper 32 bits are explicitly undefined. Needless to say...
SMM and then VMX and SVM had to violate that to function.

> So a properly-behaving CPUID implementation will always end
> up with the top 32 bits empty on the four CPUID registers after
> a CPUID is executed.

True for a "32-bit op size" implementation. Maybe insert that.

--
C.
