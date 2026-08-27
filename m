Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D438758D
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857376; cv=none; b=YF8LlJr45ep/amaypKkt/S5SGNxH96n7uUlLdlPqBTFfpR+acu/BrqBSiYpDPVZB46UPJck0l8+Hc1l++Bmd5r9wAS/1xNqDgK2r2d2FjHiLGIANakEb4OJSPOUo2vcOCyR2KKzzyoACT9G+P0lLRmfii2kfEecWN3sM7dmx3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857376; c=relaxed/simple;
	bh=9lVDLbum0cYGjweomvuk0/pgIbbEUjezvszkJrcLLfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7oyOGCZuVZ+kYelt5xMRlcMVQ8qaJqI6nwFv4bfAEEeBcellxYCxdVB7z85oUZthAxMx2DhMOTHy5c8wmVoqdPc6vaWaxOageuKsMMEKgZtBxu5mJWO52LvVcQdXbdIzrTUxs8C0zAt6uG2DZE99InY5tGi6v2N2X0QlObax4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTLuAgE/; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTLuAgE/"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c5810451so291358a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787857374; x=1788462174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jz9Q8lzA8kr9Cui0qigAU1tqPWkdoLyFdmY0G7Yt6rM=;
        b=PTLuAgE/60cxXlouWIwv5oZPv6JK5nXoIyXh79kD3br0wD66PcEMs4sXz+kPKG58js
         i0/liVdnJR+r7/tr0+r3ZqDee0uh+u2XO+XUC0Pnrt9u6hg2HDbH/L/Vf4xdkDjr6uuR
         EDoxRoSIhMyTrBlRPj7h0pKncYjjfVpTwB13YVsM6SiC0ObaZSQqzj/4aDFjTfLnqPfU
         p1sWMsy3NP7s6iR3kWmcjM0jbg9HkQMAHHuc8w5ddMlAo5Tz/0S6HdxOuIOKMokFn33R
         TGd14CffOhc05ToEnKSUGYO97I5DIcZvcVQMiHDOMZCh3YNcOl6VvIvhCDJb47dcadTF
         1qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857374; x=1788462174;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz9Q8lzA8kr9Cui0qigAU1tqPWkdoLyFdmY0G7Yt6rM=;
        b=Odt9WrqBjEy8ZzA7KJi17DAdLYmv/Ha8Aj508F5OEJOpZ5AbjHITwDPweRxLQFoBYX
         GebdaG3BQYSYzSMerU6tcQVt0Iy1upaBsyFTMNIwM19rtfVRfdnQGGkkl0LzBZzBoms5
         vrArRc+TPrWHI563kJ5If8GJeKyQfRyOXCUWCO0hNhphfafb1fVGd+vUDb7E4ckDO2zD
         n8MJFLKd7IAT4YEdYph+xUX8PplL9AfvYEHI27t6IL08vCXlFR2gpq4zUg+Ar9Gz76ew
         r+nYaj9HnU3yW2b3c00rldpVRLma1HEG9uxNot+ZY08aXLsNWnOAkIPrZjm7JT76jWAD
         OxPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9tN+RKAGSm4XuVHnA97YgVQC4cqcm/gxI4PRllXt4KCtn4Hl9s8p393+Cav3B6NWjDoA=@vger.kernel.org
X-Gm-Message-State: AFuF++lZqX/dv2fIrIQX0BuqYtbP1hz6YWarEkzAoB32QA7BVl/2Mzbi
	RkPegYOXyblZusYAOpJrXxkMBp159/nfpmEGfXvVPhMZqhaiX2EnqnWFUJG1xLzRTVupHP6w8cp
	MX5to6g==
X-Received: from pfqf3.prod.google.com ([2002:aa7:9d83:0:b0:84f:7ce1:5801])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3021:b0:853:2ca8:c42d
 with SMTP id d2e1a72fcca58-856297300f5mr2702720b3a.2.1787857373608; Thu, 27
 Aug 2026 12:02:53 -0700 (PDT)
Date: Thu, 27 Aug 2026 12:02:52 -0700
In-Reply-To: <575b25a59231cfb7bc5fbaf4bbe45bfedad1e3a9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <827b213a9482b417abb1d172438f0fdbfecd4c7c.camel@intel.com> <575b25a59231cfb7bc5fbaf4bbe45bfedad1e3a9.camel@intel.com>
Message-ID: <apCJ3B8zlVImTiaV@google.com>
Subject: Re: Process for doing early internal type review on the list
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Rick P Edgecombe wrote:
> Arg, fix Kiryl's email address.
>=20
> On Wed, 2026-08-26 at 16:59 -0700, Rick Edgecombe wrote:
> > Sean has long been pushing TDX developers to review less internally and=
 capture
> > everything on the list. For several reasons:
> >  - Avoid thrash by hashing out things internally that are just overturn=
ed later.
> >  - Capture all the design decisions in lore history.
> >  - Help developers grow by getting comfortable working and making mista=
kes in=C2=A0 =20
> >    public.
> >  - A strong personal conviction that through some confluence of intangi=
bles,
> >    working in public produces better outcomes for the kernel?

As evidence, I submit the myriad historical KVM commits with godawful chang=
elogs
and no meaningful on-list review/discussion.  When things go wrong, knowing=
 the
intent and being able to retroactively assess the review process that yield=
ed the
final commit is extremely valuable.

E.g. KVM added 600+ lines of code to (very poorly) virtualize MTRR memtypes=
, and
carried it for more than 15 years, all because of misdiagnosed #MC issues t=
hat
showed up in early EPT + VTd enabling.

Even with the few breadcrumbs provided by on-list review, it took me for fr=
eaking
ever to piece together what happened[*].  If all of the review had been don=
e in
private, and all we saw was the final result, then it's entirely possible w=
e'd
still be carrying the MTRR virtualization horrors.

Another way to look at it: would anyone (seriously) argue that changelogs a=
re a
waste of time?  People can read the code, why do we need to explain what it=
 does
and why?  Because anytime future developers are forced to make assumptions =
or
guesses due to lack of information, the probability of a mistake being and/=
or a
bug being introduced goes up.  And has been proven a hilarious number of ti=
mes
this year by AI, humans make a lot of mistakes, and the more information th=
at's
available, the easier it is to decipher and remedy those mistakes.

"Documenting" mistakes is also extremely valuable for helping others avoid =
those
same mistakes.  E.g. look at all the bajlilion edge cases and wrinkles Sash=
iko is
pointing out.  Having a public record of exactly what can go wrong, or what=
 sharp
edges exist, is a huge benefit to future developers.  How many times have f=
olks
ended up on Stack Overflow trying to figure out how to do some obsurce thin=
g with
e.g. inline asm?  This is the same thing, just specific to the kernel.  It'=
s a
public, searchable record of potential/common issues and in many cases, the=
 cures
for those issues.

[*] https://lore.kernel.org/all/20240309010929.1403984-2-seanjc@google.com
