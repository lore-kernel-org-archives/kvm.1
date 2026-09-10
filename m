Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5038B7D1
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068785; cv=none; b=APtwTJa2lEXYPvr6fee/h68FWLf1UTYTcTLiv7tHxmFsyvVtQ42V+s2MDxhAeigcob3AyOFa1Gs36ghX+sVdaRUdmuyZzJcA7wK0pMA5PMGczJ589UOjplVDAjA/pIRGNJ2Fatv/zdJzbRpSAACtWXzezJY0xoaJ/v+F2UM45BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068785; c=relaxed/simple;
	bh=OaL2gIY4/rvYENHa/VV3JZ6qts0VkGiuYhfofseuZ9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YPOM6RsVmXb+l8u8LiDRnyeERz/xtWRrMLsTw7us+CLPaY3MHD4ibF2qaCvJiA5I7SQ5H3gXQPjJLKWo9Ovd+sxiRcZ0QPeOmLD1WBthFJV4369z0QLtAvGvPEKVI+9tEwFe/Qbni1zAo3Uegxk4Dc344IkeTtmRVMw6JseiMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tepGuMwe; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tepGuMwe"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8633c0d7353so70777b3a.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789068774; x=1789673574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0LO3wehpioybmx3i7IEixw9RnbaJnGBUVwi8qW7M7RA=;
        b=tepGuMweAM+uILF1KssKPC0y1nCdviJjfFZiQnschqJAPvW4VLZD2l56daP+wpV2xS
         Qaw1Z3a2vlIXkpCJN1Wq8FwNv5plD2A7EhavmzXgSULk6D2L29Kl9lHd7t8pLU8kZh1V
         vkvIoBrmMBrw/sddhF4vOtNEhKpM0tqM9+g7u0PdsRRWJZkybnmxE0a4Lxu79004lCLO
         Pt94NagDmeg4fUsu/ou0e7uOXc5mcUiEubTSOeLcZbCDsK7wRiASCP5QNfXc5dBQvLEg
         3+0fd1MKidjU2rwws0HqBrSy0UeZSmuzIHCu06JnmJHfo9Vprl2gwFbig+ckNspRa77T
         cQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068774; x=1789673574;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LO3wehpioybmx3i7IEixw9RnbaJnGBUVwi8qW7M7RA=;
        b=QsgurT8lEpbZrdu3w6zTTVGYaw1i9bJIb7fdeZ3uN6ef8A4aNIjOBYDT3CTuZYwpY/
         zYrtXVzeU4Co68WRxlETwmML1RBy/XWDLKQBudzm3rIl6TY+IyhkcE4d/7TdQ4dp3a3a
         /ojVaUkeGeTvDY8xu2bkqNoFFYbFOnIiz6hehY5D5n8bq1Xvi3D8YYO/X4/KTTGBe1pj
         w1Zp2Z5mHXBGwjk05CDkbkXHBh+DtX9V7jHzwP7eTq8MPwdrQrrOHA7NuUIVPiBaoqVy
         BMq2AwlTHNd0YEtT3VOQCqDvo8LUP8Gxy/mOQuoBdxOExE198IMuSr6QbTrYD94+g8W7
         5FwA==
X-Forwarded-Encrypted: i=1; AKwUvBxRdhSYQwgkIgAVllPFAuP2MRp7gPMtNeFNdL/293r86Fu90/7ODPqa3RW6ksZds/k5BJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mWFkdYLRmQ9s1Anc+O1258FC+J1I0X55tLN9t2M5TTB4PKc9jW
	RQ2BnuqPWaJ9e0ToWYHue3IO9gjYHKUcjc+eP8X9VSnDot1XdlyFVEvn5bf/xJ08P4cyak6P2uU
	6y+zm+w==
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:848:49f6:6f5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad8e:b0:848:30c3:45dd
 with SMTP id d2e1a72fcca58-86b3041253emr623075b3a.11.1789068773550; Thu, 10
 Sep 2026 12:32:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:32:52 -0700
In-Reply-To: <aqMBidJ_96qroogH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
 <aqMBidJ_96qroogH@google.com>
Message-ID: <aqMF5GVp6qHb-WcY@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, Sean Christopherson wrote:
> On Thu, Sep 10, 2026, James Houghton wrote:
> > On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > I wish we could just change the uaccess primitives, like
> > {,__}access_ok(), to check that `current->mm` is not NULL (and WARN
> > and return -EFAULT if it is NULL).
>=20
> That wouldn't help at all in this case, because the access_ok() check is =
done
> when memslots are modified.  Which is the crux of KVM's problems: KVM dec=
ouples
> the initial checks from the accesses, relying on kvm->mm to
>=20
> And even if we hardened all of the uaccess helpers, we'd _still_ have pro=
blems,
> because it's not just a NULL current->mm that's problematic.  The last re=
ference
> to a VM file, i.e. to struct kvm, can be put by a different _process_.  I=
.e. KVM
> still needs to guard against reading/writing guest memory using a valid, =
non-NULL
> current->mm that isn't kvm->mm.  That can't be genericized in the uaccess=
 APIs,
> because the rule that only a specific address space can be used is very m=
uch unique
> to KVM.

Oh, and I'm not saying we shouldn't try to harden the uaccess APIs to guard=
 against
a NULL current->mm.  That absolutely would be worthwhile.  I'm just saying =
that for
KVM, it sadly isn't sufficient.
