Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625055;
	b=qe4/yVuQbbPBcn9+i4aR2OA/frtIfqnWeFT3rD59NutR83hLtXxKvWhtiF8gIvKae6sx
	 UfpNHJNJAeOb6/8yU8CB3xz3J1UYx/oCbZo6XGN+xFZXHR+zpFZhNzdzRkFvweCqJw+fo
	 OMhS3W8rjinOdkXoQvPEC8Ho2sXg/CqgmtlX33t85woLuScID8q+W2mjyE9PdSweCB5fe
	 IkwUnDj65mAWUjc0hXMDZq5Jxrz8WKInBuG6K+w2PxrfBauZ2IxIrlxFUZY4JgiBfTLWe
	 iaqD0iui8qosHFBIR9Ne5y5OlNmAotrIgS1lU26ozTXetQOTVeKpwEbw4yGzjOZN+kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
	b=AmQs3RNP11naW9ea7M37thUB7zfDMmKNE+F7Eep4OSrCaYl7zavO7HE+PEuyq5UnDyYn
	 Jmbmx3V5lc/g5h9Nwt84C091LX88IWWLv+pRXiqBIVCQVC590qNb80NweFUEA88HGdYx4
	 1gZB7Rwaw3HbwaK8RGuSw9JMFg3AezugJM2MxtISomVn3gR+d8wNsP+IsFhlI9qwBMp8a
	 5FojAt1wMhBskxG4LCkRfsLp8rXmbNEepYuFQaKDhzdFcMjMCuXVLrHurXP8+Y6sdR9Tr
	 Tb/tzyC5XupZsJvOySTMWey9eMXSMh5IiozWkgPVb9bpwTwHf6r6slVp9P48HtH4eDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D52606A330
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D52606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c51a02ad3acso146648566b.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 08:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625054; cv=none;
        d=google.com; s=arc-20260327;
        b=CUEXzWnarInxpW2bjc2LUfYmVwj/FaWFSr7Dph7Boc2i2QwX33l8VzjW97pYM5Z0+D
         yvZrPP0AF+xH7BwN/2UkH7OU7W57tQGGszTflzijbGBqwcC1sfxK02b4br0qaG41ldPH
         8xI7IVs0tHHufs31ASvaJh+VKROCWuoI+lPwA6lcqxYVuuDqfB0496Pup8thLxsUCat/
         hvfJXnxA97WDWFtO4VPgJzlA4hTqA5Pnymbnutk+5Jh3G4WA7Cf3COkrBEPBBfXdOP+j
         Q4CrxLLkwDffE8aMPzP5vekxRyxOx1BuInFEUghPx8XyHFmNc+ZkwukmleAY9vHF5Gxk
         gujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        fh=eOi52cNUsp/FWGRMKkcmzo4pODNiSfcgS7K8/npAyw4=;
        b=NKHom7ruRq+q9ayMTW7bUz9GC9wEQfljogRE49u1JHvkIQVDMinExoZW837XsN6jxF
         Xuzl2U9xEbUhAOlnjbX7tYPcbae+vAFlNXpnP46/Ma5a0BoBOezIpH0BlqQxUlpnudOa
         HwtiyDggLTuMbDBSrw7Vmm63aCiJFP7Kx+N50qbvilXRtv7TrmLLpr20Wxh7hgzneLxk
         fxJ4G/s0HkbVXa79Ix4GMMoYU3OpJV0GabkyLYeeINh55lqSBuLrxuE1SuMHaQ553L8u
         uLve9pzPBJMXgybcrRB23xQDvAXlZ06cr8O+ejS4sMQ28hZwrt5WO0KwteHLhmMnxSir
         69AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795625054; x=1796229854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=PKZ23RQeMEttotX4OBPRP2DbbrMEB51nwAQlsHi3Clsl60+KLwydytyVzIwS3CPrsp
         gMCa0qLojqUmZPTj1WgDWb2vfDDzy8I3ouZC6AtzVQzGhYkAtsdS7I194LfKbKzPHVBH
         9FjnQKv/TdlaTy27yqxtS+FRu+TCtlSdjsR4QOyB9tkMnDrs00BEwfTTEGdJNrrE0d1S
         i0G3BgU+8ocwt4ScMKi+JN47+02WlDqK9aHu8g0fQCVcWCnmaTG9N306L0mPKog4H/f4
         BgsXgGhnHP8RFqRdmh8kRVgxVbHO2JS8qa43xqFnpf9P4Z4Esbd1QfxvoHuOMiibIYtV
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625054; x=1796229854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=Fv4aUbMvq9pE5TwMp9Xu5/W84IyGsrkQSHGs82B6p77Tau+jHl6+u7IWNxdBt+pMJ4
         XFUUrISI2LA9njSNP0emkTqnDihZ3PaZR9BZ35kA5vWJF/UO9GB/CRw0ROYquJcGZWpA
         EsoRqnJH4m3QSvVBib+PpDI4IvtRPfUgdqMH/OPHly90JO+9xV5jU50b485HhiOnEK5L
         mS4f9DLPksB7KHqndJVXa88DthfWbxgPmGswfINrffWabVLM6TXhDcnqQ3tSpAD6OFQK
         /6e4RUzV4fpi8Bm81/8hFsLH5RE6zzOlTEIBgDiOnbI7KPb+2Zk+OtMbX5MS37b8k9Y2
         2iWg==
X-Forwarded-Encrypted: i=1; AL+hErE1y8oNPdI7taRtidmgRt9GoqU3qfusib40UjWoDyPYk3ILh+VPO4QlUjd4NjZOWz0thAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5QrkoSuiOcLmDTfZY3FfjAMq5AbPx+OgUlRDbqO+G6DT88EyA
	feNA60BjTzNasEfKhhRsgYhp/9VQByRz2Qg9Uba/BlW4XMUln0atKbxn32rz6oRzeCIvnkMEa+B
	2EYXGi0uPrxVH/67ICEi19NuE3pJLW7MjPhC7ifmH
X-Gm-Gg: AZFdTZfW/KT1qDn3I1EGudBtD2aXvYCv92sTyM305mBUG8lVlotvvSsC+BSrMZJGxTp
	7Bcv0yA/sp9djc9dA8q+9o5LJHF2TjrUutNeKrfHALbmSJyduNWuXlWNlucIBB9X/pojE8jZhne
	mZgDGc2D5uxjFjh0YkyDIxV0Q8NBKpOIFcQU6VWkiNE06GgSBIDFHB08WyPZEp/vgDe1M0aVy9B
	392aYbpd1917osyjMkdsh9KZCb91Uy5mXKMRpOwgcnegO0Ud6hKHPtnaNrQXVT2uEqUG08TSsZZ
	SVxeHQLHEtPlLIjSmoTAwdr+AND2wMyh8kiA0SpnfdgcR8sL+iJIhFJ26tGlKQ7BCPeEbDcnZHJ
	7N9sBNU4cRxsTO4BLhuuTT6ydr6ybadLWanII4wC94G8TAbXYt9LP8XZIOO+O/tVtm0Ii4Vt2Jo
	rFXeODs9KZMeorozNbEtxPuqlPUH5mxkXkTjIpLmEtsTBQtwX0yIs=
X-Received: by 2002:a17:907:6d22:b0:c51:40e:847a with SMTP id
 a640c23a62f3a-c513a1e6fdfmr1639688066b.0.1795625053094; Wed, 25 Nov 2026
 08:44:13 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
 <20261027231728.1466446-1-jthoughton@google.com> <32fad21b-5bad-4640-97df-ef0f638cd9e9@app.fastmail.com>
 <CADrL8HX5vb1PGDpWzp-eR0rNfsMCVUhFa9vp_WZZx2eJZ+dfXQ@mail.gmail.com> <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
In-Reply-To: <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Nov 2026 11:43:36 -0500
X-Gm-Features: Aa3M54qTCDON0Zo2YJDXp5pBtwrXjTcYjv8NoqDjQS_XV_tl8JrBb-LQVlKEL3Q
Message-ID: <CADrL8HUOZs-vWRyM9p+Na-=arRU+Gx_cWMLbxHmUYnho4fAUXg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, kvm@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 24, 2026, at 22:10, James Houghton wrote:
> > On Wed, Oct 28, 2026 at 7:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, Oct 28, 2026, at 00:17, James Houghton wrote:
>
> > So now in v2, the _nofault() helpers themselves do not check current->m=
m.
> >
> > I've uploaded a draft version of v2 here, in case you want to take a lo=
ok:
> >   https://github.com/48ca/linux uaccess-v2-wip
>
> I read through this now and it all looks good to me so far.

Wow you looked at that really quickly, thank you so much!

> >> Since in principle every user access should go through both
> >> access_ok/mask_user_address and current->mm check at some point,
> >> so combining the two as much as possible should help long-term
> >> maintainability.
> >
> > You're right, and v2 has been restructured like this.
> >
> > - The check is in access_ok() itself: the generic version, plus the
> > arm64 and riscv versions. __access_ok() remains a plain range check.
> > - The callers of mask_user_address()/masked_user_*_access_begin()
> > check current->mm explicitly. There are about a dozen such callers.
> > - The unchecked accessors, __copy_{from,to}_user()
> > and__copy_{from,to}_user_inatomic() (and arm64's
> > copy_from_user_flushcache(), which also relies on an earlier
> > access_ok()), keep an explicit check for now. Once their users are
> > converted to the checked versions, those checks can be dropped.
>
> Ok, sounds all good. If we get more than handful of mask_user_address()
> and masked_user_*_access_begin(), we can always revisit that interface
> to make sure the check can't be skipped, but for now this seems
> like a good tradeoff.

Great!

> > Compared to v1, this also covers get_user()/put_user()/clear_user() on
> > arm64, powerpc, riscv and the asm-generic architectures, and arch code
> > like signal frame setup that uses access_ok() followed by __put_user()
> > or unsafe_*(). user_access_begin() no longer needs its own check.
> >
> > What's still not covered: x86's get_user()/put_user(), which do their
> > own range check in asm, a few architecture-specific paths that call
> > __access_ok() directly (e.g. on alpha and sparc32), and arch code that
> > calls __get_user()/__put_user() without access_ok(), mostly trap
> > handlers for user-mode faults. Probably best tackled later.
>
> ok
>
> >> There are probably few enough of these that we could address them
> >> by either adding current->mm checks or converting them to use
> >> the full versions instead where that is an obvious change like
> >> that usb gadget driver.
> >
> > Sounds good. I'll send a separate series converting the obvious ones,
> > starting with the usb gadget driver. I think that will be useful.
> > Let's see how far I can get; hopefully I can drop
> > __copy_{from,to}_user() completely.
>
> Ok, perfect!

Thanks, Arnd! FWIW, there have been no syzkaller issues so far with
this WIP v2. :)
