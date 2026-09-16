Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C06495AD6
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585639; cv=pass; b=CKwtQboWN0USAlxwW/FtnEfWo53bmDQnEp9IWyjZGwZR8uwy3pz7mfvfWkheQV8VAURqnw9Fhjmk4InyGSSxQVV5B1vBo0PQNMV7zBOrnRNk74bKQhgeHCRQmMe5vxr7eORAzHN0AtHYgtSE30/txOApgc20ewH/Arl6blAtfPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585639; c=relaxed/simple;
	bh=YFbcwtgNuX0U1EJKvV9Ul//2Ots1PofZrH0PIe/ShVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaIMa4pSmNK4rGp6ITd4Xs4dR6QWM0qLc/cArfDypRS3mBec4eyjuNZ7jKZl1Lfjt9IXvsxUVYINyAua7UG28+1yiXzDp6HZCNAHrTUF81wYtllUcMtsle2h3z17TK6V8y5accH5vkNsPNxdIvaxR/N8xoKo1n6FJo0zgVEzv78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEwPAwcB; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEwPAwcB"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so1676a12.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789585605; cv=none;
        d=google.com; s=arc-20260327;
        b=pTsG65MM81tyGUqcqBSeWLsWg6QrjSD3uxqF0hg6QRkDLrrBzLzXz3heRu/rcJ4Qkl
         LsZ95V4huOPIYQZAyB3BJphQE6zVznFucOir39IBTkLmw0Gf0wjUkmZdAqSPz3T+1qFm
         F+j5VXCjkNqVTN4CJmBFO4h+AjCZJ8mLlQTMNSFoX53JLPlSQlzteX8aORbj/fM4hDj+
         GOu4MQb7f48qvOrb1kiWoJOlsY9lBYMKeJwaqV62Bg6FDfvqDMK0JB6rhYBYSAybGqpo
         nQiq/b91FTO6rknkf/lAe/SqBW1VnjAtSqKz4a986I2DlGtOretK203o/8EuKSi1jQP4
         kTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i8q6HHOe1ZAhbklRTyDXKcKv9K3nDwMAOUFrm0T0XXw=;
        fh=+KhJXm6nk+M1C+T0z5d4VGG9eIwKwdg4EHnnXyQP+vo=;
        b=Z9K5ixR6SaI8wz5NWlLkmlGajuLif4Uax7TmWfPg2fsCHTPEuVGbp38d0mtBkwvwRQ
         AkBHmjwaulFk8aJVxmXOmBymj+bpoD1OEN1O2qwU9kBsf9VLrnk4C84sEhlPxNVukslB
         1Jlz5ejBIC4slir1ZRjUAUEZCEft/cZo1rETqYd8eE8IA8hlhNtkXyY9KL1X2NfyZKXW
         UePfEmnxVCv1bm8lwxqjuhkC7AcM9xYnx6gS69GojWDY0fqE8j3Sqp57ieJJHSUYkSKG
         XGn3SdeIVBi6W4Ho11pY5AMhbProM7rrVSmFCq/eUrXLplfV/16XtT86ABtLKzcW5BOb
         rg/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789585605; x=1790190405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8q6HHOe1ZAhbklRTyDXKcKv9K3nDwMAOUFrm0T0XXw=;
        b=UEwPAwcBGKJp7rc++RIRYesLfdQ+S0085lWyBL4LDVLhOtVwvpIJeN+Wx9285wB3Eg
         QXvzFPLMQPkUP7HFHWag25Xiy0mo01/6MHF66S9mjVK/w6FWsjMki9G6icmnv8HJKPSi
         Ab9Kd9DkOJPjfdVWXg9xpvgUX6bLY1AOOY4vZOCFso+hX/285VODKZULbSOoRUSHtHez
         5H9cTXObDWc7XVlq4KgzSTzjCEnUvHEcwZ9DUTRsigiPjkO0ViiK5MCvsKOXbO7Y/v0M
         7KjjbxNRsFatmNhtrpYdkYmndMo7tNg8Rtbe+MYTOjTrNnHa1jkuU/qiqG3m+83aRVdR
         MeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585605; x=1790190405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8q6HHOe1ZAhbklRTyDXKcKv9K3nDwMAOUFrm0T0XXw=;
        b=V03HdveG+0OGCPnavvu+pPEK+oBg4EQ8ULPl0T6H7mxSDI5Pc92B2GocXVHYQOPdxb
         bd5RpbPYPZzIjE49+3g0ckx51dB25CCCmwySWCCUA2+Bdv4JK9SGSjh8DrkE3NWYxMFe
         EU5Eqrs9HN6iC0lubw4dizBs/0mFKl1Z31f0e/v8B1zUR54L8EhqlOASWpAYnrhqnLWv
         kpqlnUv74n9s64p+WGXAR/zxYeM6wUo6QUrk/GHQ+PrHrzQFL4EteW2LmqGXjHsXKTLb
         U4HCvveV5SbR/tKGMgKQ23MXsrH+duLhNehIwddne5IEONkEkFdpR8hzecvQ0TR9fBXB
         cYCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZkypq7stNRj84DwAb2CuC58JbicpreEoEoUvJeAgfbXhjdlgF9GAEXC01Q6pDr96Nl/E=@vger.kernel.org
X-Gm-Message-State: AFuF++kbGHtnwbjy0hxpK+E5VVSle7l+LF2tMCgyL/Ek6Bisa5rTbhpb
	Z+sTn2nmRpfIuTFhhsf6uSKJpeMMABWh6GirUee7pNSTjrqxiVzQgkTLjofnoscqhUINtEgf2sv
	MNhaIB29JJg4r4iufxy+ek+yqjsHgrbH6fyFL5ZWC
X-Gm-Gg: AYBFou2xFq8kbTs4Yf49vfZkHiY/FB+qFp52I1Og8QmE4+7UCI7Izo607cRVKNPzEOx
	mD0pb6207Tw8v+SBdJ5lJtZZbtgkAIWatakGaADGC9SJhAJMiTlm//ykLHDYMJfpIzvH9U1tyyL
	37JgHoCoFDb+4i2Vi9x77MbnEIpnEvumocwHOMk3HdmwdvJKtJnbCKbc6UpW9T/U0q93yBMRBE0
	HeQ44sX/gbbdA7bRnhKOeuNUqFa4G1JFB8g4bGa8STy271Blc9TfX2MFHRfQs3KKyKiHYJGkfsX
	l3WjEsPQ3isPPxNduoFOCyFQmmXLs2+YoEmok2cb7FWIEWbBNfa+JKA=
X-Received: by 2002:a05:6402:b2e:b0:6a7:453c:a166 with SMTP id
 4fb4d7f45d1cf-6aa37503e67mr7027a12.1.1789585604831; Wed, 16 Sep 2026 12:06:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
 <fc88f299f41c99ddb5851c24d97970dc29584876.1789281096.git.zhang_wei@open-hieco.net>
 <CALMp9eSv77sBcfYpPJm4Uk+9CePV7YMdYXhvBHKHSvacnnRBUA@mail.gmail.com> <3451f275-d88d-4db9-acb9-ca80d717df7a@open-hieco.net>
In-Reply-To: <3451f275-d88d-4db9-acb9-ca80d717df7a@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 16 Sep 2026 12:06:30 -0700
X-Gm-Features: AcwNN1Vb7avB1LnW1gDR4-nqujxfy2WLNfEbAl-1PKaPYp4bwb_CEzgH4WJPJXA
Message-ID: <CALMp9eS690dzVm+H55U23g8r3Qwbk4V-=vp-J4Ajvh-iC4J_4g@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:26=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
>
>
> On 9/15/2026 2:23 AM, Jim Mattson wrote:
> > What if __linearize() fails?
>
> This was also my concern with using __linearize() in v5, which is why I
> initially calculated the address directly. I wasn't sure how to handle
> its failures when we only need the address for EXITINFO1.
>
> Simply propagating the error seems questionable, since em_invlpg()
> itself skips the invalidation on failure and returns X86EMUL_CONTINUE.
>
> Would either of these approaches make sense?
> Option 1: Factor the address calculation out into a helper shared by
> __linearize() and get_invlpg_linear_addr(), leaving the checks in
> __linearize().
>
> Option 2: Extend the existing flags argument to __linearize() with an
> option to calculate the address without performing access checks.
>
> Both would avoid duplicating the address calculation or modifying
> ctxt->exception just to obtain the address for EXITINFO1.
>
> Do you have a preference, or another approach in mind?

I think a comment should suffice.

EXITINFO1 should be the address that INVLPG would have used if it hadn't
been intercepted, and the address that INVLPG would have used is exactly
what __linearize() computes--even on the 'bad:' path.

I know it looks like I asked the exception-return question as a "test," but
I actually just realized the additional benefit of my suggestion to use
__linearize() here rather than open-coding an alternative: em_invlpg()
makes an identical call, so the two must agree.

The APM, as usual, doesn't really cover the details of the corner cases,
but on the Intel side, the SDM says this about the exit qualification field
for INVLPG intercepts:

  If the INVLPG source operand specifies an unusable segment, the linear
  address specified in the exit qualification will match the linear address
  that the INVLPG would have used if no VM exit occurred. This address is
  not architecturally defined and may be implementation-specific.

That's just one of the scenarios that leads to the __linearize() 'bad:'
path, but I think the same logic must apply to the other cases.
