Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21F4FDA7D
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061027; cv=none; b=JcDqxY3cUuZqNaWx1kyiTE/I4ggUJabI9YMJ64oFSt9dxOeXsdRnNDfq/zdJBshG4MujLghHmQZffYtR3N/faL+JTqqVjzMSjDgpbMUY7zeLcDd5vVk/k78ur+m4MqwKPMi9PJoX5Hs8bH74D6S0sAh+UNzrkf5ZiVNyJ9H8Jls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061027; c=relaxed/simple;
	bh=3MK+mM+3TL+vIpJDgBfEo1/4CmjZ/g4CLaacnDtPy8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj59frE6P5l0iPXMl+Z4+HP+8v6/7JVK382Pr61nIClWVWuH3SMQ262JUtOXX89M09sUVBtvkkEB4ODLSafWU1l0YF1rv0YU4uKDW7eWoLgkzzkyNsL+t1TCAJdz4VzPArkwEijxfcXS+/4sSxk6z+LcbMvfx7tQ6/MZqm15hU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vkxuVSTi; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vkxuVSTi"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3MK+mM+3TL+vIpJDgBfEo1/4CmjZ/g4CLaacnDtPy8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790061021; v=1; x=1790665821;
 b=vkxuVSTil4afT2c7Go//Xr/Iah+NABcWEL4VGtVCyOUCUFQGo3ZeWCfXYGwn9LA13z1oh3Co
 0kTDqS3UyyL+tixiq1A53sBJiUPFPRoowBlx1oLk6NZKnQlIRNJLcaaOoRumkCFy2Wk9LLuFOn1
 pK7SPk/VN3vA3vzj+xiY0wzY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fe3e036acd6e1ded;
	Tue, 22 Sep 2026 07:10:21 +0000
X-Mizu-Trace-ID: fe3e036acd6e1ded
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso3864e87.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 00:10:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBUC73N76mu5mYRbQ5bJ6dTLkWp9cFfhZRXh3Zd8ntblVqpO9QP8MRkhjEo1sONGngSdo=@vger.kernel.org
X-Gm-Message-State: AFuF++kOoGGxybCke1UNIwIR2qP1w2jr85f6s9hpwrAfHiCLInD/83jQ
	KXApKhEtnnBTFAoXuEsBMkLbbg5O25haDvJN/n9QvOQfmFKbCAcRgeSx9IGJWn2p483G6YTMuos
	vTE8MtWrxCZS9frdSHquMa5jWCOF771WC7DOdiyMT
X-Received: by 2002:a05:6512:1394:b0:5b1:ca0b:25d2 with SMTP id
 2adb3069b0e04-5b8d324c0a7mr113236e87.4.1790061019960; Tue, 22 Sep 2026
 00:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902134118.2718200-1-fuad.tabba@linux.dev> <arGRhHgP_izSwW4T@kernel.org>
In-Reply-To: <arGRhHgP_izSwW4T@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 22 Sep 2026 08:09:43 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy5saEDGkP-19n4L19AbSd+ZtjpDVsPABiZkek6D7AN5A@mail.gmail.com>
X-Gm-Features: AclHuK8I6JcWPH-f3J63av1v70AyMxgZAJlJPzSXAdNB-ZOaq8jKoUkgDKbDOTY
Message-ID: <CA+EHjTy5saEDGkP-19n4L19AbSd+ZtjpDVsPABiZkek6D7AN5A@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix arm64 sysreg header dependencies
To: Oliver Upton <oupton@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 21:20, Oliver Upton <oupton@kernel.org> wrote:
>
> Hey Fuad,
>
> Thanks for the fix here.
>
> On Wed, Sep 02, 2026 at 02:41:18PM +0100, Fuad Tabba wrote:
> > ---
> > Unlike the two existing sysreg-defs.h rules, this one's recipe is a recursive
> > make, so its prerequisites are not the recipe's arguments. They only decide
> > whether to recurse, which is a question tools/arch/arm64/tools/Makefile already
> > answers. An alternative is therefore to drop the two explicit inputs in favour
> > of:
> >
> >       $(GEN_SYSREG_DEFS): FORCE
> >
> > leaving that Makefile as the only place naming the generator's inputs. Both
> > forms regenerate the header and rebuild the dependents in the same invocation,
> > and neither rebuilds anything when nothing changed. I kept the explicit
> > prerequisites so that the recursion stays conditional, but I am happy to respin
> > with FORCE if you would rather.
>
> This might be the better approach at this point. In the unlikely event
> that new dependencies get added to the kernel side of this, I'll give it
> approximately a 0% chance that the author will update this rule :)

I'm on it!
/fuad

>
> Thanks,
> Oliver
