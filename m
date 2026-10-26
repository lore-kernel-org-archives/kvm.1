Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058730;
	b=DTzJCBedqhkxkumcI0THGjhNkteZ/sTYGmFrAlZPA6i9Q/u5t3r6lO5oz5dvHIjLEORX
	 rbpZD7/AY7sz2YmWDyj2gzFdNn/bkrBzaf+CPnoUISS1gpRdVi2j+YsxzX8RDXnS8PR9M
	 Y32l7vt6Lg294QQxeZXQCPiiyeqm95FLl2tIsp2GNjBlsRw7xsZqZ6AyxpZKZiPJ3ut4i
	 hXk3rSWlydzy+itef8hlOVL5eBmKz/Aej37xEzIu07N7cvikwws0wrpvsDvcC0yBrAz0w
	 PmWA9HZGkUxsfGio2M5SU50gmAuR3mGf9Qpy3O//xEMiHIq1t0pSsbj3vGvTka/e8wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
	b=MxY7AszLK6VSzPFOqCLOcc7BhNOgRnA4iU261BoHmKPEZdc99R3eqiwvFxNFp6T31HrM
	 fIoSDxE6f8j+5y2wue0n7M0xuHdyIA4wSzt7926wdD03NTQDpfY2MOoNShLMzQCWvTK7f
	 /zamIRb35lHsD8lMAGyUxp9w5Duiqao84qlS0ayujs9hZNVAo0L+RBg5s9YagoMBCcs0p
	 bwh9h2sVrJdGsZSuF/fPg8fRaoWaS3SKUe/bFY+xhisEcG5WmPidR3kjlzOYwmvWeRUCb
	 j0DZWYsG1X8ZMltZItXfWqFGPH20SUrFRlDwiuAuYIh6Wm26NflCOlYi54xHNHq/iMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF714606A31E
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF714606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso470498666b.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 16:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058728; cv=none;
        d=google.com; s=arc-20260327;
        b=F9fGIvGwvQ9gPbNAi4CaMjpRpAxOSLloVNnlVOHMyPFT2KOF5pRuq71bxXq/yP7qvJ
         LeWpYLJ/8YKorEX14vlBblxHfi3tjagopbqYyO+Cq3ya5Rx7WWH0pHZZewegtiMCYi7u
         gM3wo3NlFomTXSdBNss3KMatMrKEsXGClH0SEAS6xcKp+dblwGQX6Y+/pEUNKLHIzyzP
         N5IBU54cBsuIzzWyNB7sS5xG09gpDnvWxLPE/wva/TY8TvNX0vGOre5X/1GkJrslVlMp
         Oy2ZvpKz4Fa/GOWxeYAcdJWSbqHvmM2essUANRQ/U/56ErOgcdwTFWG8s3qSU41se4E8
         mcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        fh=FsSJ5Tkec4zv6/td8HT3BRU0SW/PFBN/61r65leO/ig=;
        b=myhMLcxBeUbI+zmAQrwMbAfBFVbcv8uAqmQvQc1DELkpSzK8uevZgx25gs6+E27T+S
         edETzJQYbbKFp4hImtWRj0H60QVZ5tugNRflOJGKAxTsE9n7cVxxTXDiU6GHZ3BjnX4I
         zAfqtWG8lMib8srRGe8GJnFS4DjJ8XbeNjTccq4r9L/frg4EUvH96DNuDKxnfwzUv6Xi
         G3KB4piyS/FUa6jgGBHqfF3InzZK8p1OwQuvkHB/U6QnyBdVuY5Ce0q7rHNWbQ5l/eMW
         X+DaGBIB1CYnp43rr1zjOFHO5nvvfnNJAFrUWntNe2WrqBCePYHBSE66IWhb7SNwCP4+
         fQ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793058728; x=1793663528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=IrwijN25Y5XuhkNoEvpxTGUzu2F8Fw7yumOC6bQX+sv9sI5cIkUQ+8qDyW8Rn0leIE
         KD/M3UgHYaJH9qxw5QEzap4cvaO8QRp4WvUy/b8d8qlbP4zjT/NLwA46mVK4rk5TE67Z
         hbcIs7JRXy3S3BU1Zp46QexhDFTfTqhgb9F5yDiJoNepIvxVOAnGlUkvuMj53pVOulEq
         nY7AospiQUxyoh3b4b1zlSlhp0Xm7S9U0DWHUHqyywQpS6V9BxBGr6qPvm7+SL/x95K4
         vKS38fvl7h/D+VqUiNNcMPjyNlpB+LfGZlaoNjHo8oTsgp0eeolgiheQhrTjRg97kEV2
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058728; x=1793663528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=Bj+Ewi4kys3EZuZ80HOBzUtBhwLF1MEfR9EPfpPGtKLU0CyKY7TOOudKHiRDzZdwAl
         vLnZxCByapghLp8ZDRXXKyt2oS7XnTeP/iaewzdlsZu0PCZSwDhz68WAbPFmCKHCVNY5
         CTyF4cYnWUMjv/MRiJx1trxRuUmSiT5lZF9X24TU/BIFOcQeExE137TbaGc5p5dxxvgL
         t9s4AKOVfE8ODESTQ681zAwukRqzoluWuI6a8vlvNkReHhRxRPVoYTgFoRPoOYQh2SX1
         7ihz74gCBRP+yG0lNTLeVAoB9LPKV6VNx2gPTxZjF5JE3hi7WXbBHpz3rYQIpCRxakby
         tZ9g==
X-Forwarded-Encrypted: i=1; AKwUvBw5lD+8BQg3quYbl6ITV1qrbzng9PAnJivpDr2egj774bFMux5BfYQHQ5oy22AMO/h2zjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0nU5DF39t0M8v9pXVXlI5OwAeUH3/gpWrPM+pzWPKp17iAgTP
	PyecLxFDs0HmHBdIJlKFbsrxhRBu/jG39RLQVlsiiOX5g1Cf+JeX/3s1tj9BV0G0WllPzvpHDt7
	S0dG6tm5UkIN+zVLowV6VH4YpItoYHTVF4o3qiDEZ
X-Gm-Gg: AYBFou1Ir2hQJyiB+yKlnTf6twbUPtjqd4jJNzHwrTlmGkjljl/HFLvCSxQ6n6FTSAK
	xpwUC4JIn3FdsBFPjQiK7gHvJxpPWXXC1WXtGm1UH4Q0Ay0Kt41T1VxrOS+ADRoA8hPM6Up/wfL
	XmgKOFlIZ14517aC2zDxW5nl7dACQF5Q3enzd+ie+pvOgCdCQJ7jvJQrM6JROBnlmj5P7qHqQEq
	DKluOTubduAtOolf7o8/xJdBS7oLaMKBIV5JcxY9aXv765FDu1e0cyfoZ96d/Q7YdI6OOGZdKXV
	TV0uyQLCK9Zk87LTrqz0y4CGYwdmLtIa+tAa3ijS811Fi3bgKsloSelwgbkPcEhJN984mfoyPdL
	ZWBWKJ+KAn4jBpG06HLL8fmAAzsM2j7vV61uYEDfH3QTz/kO17F7nAL9YYx4gMfPW7nAbYXrCoj
	ukK2CW56FsVFpHwtW1VBTMlqHqfT3BZTBf11LjOGLIESFUWJEfmgpavGzyMUzBqDHQc6zWNokKn
	dtcccaYLg==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr943075666b.39.1793058727681; Mon, 26 Oct 2026
 16:52:07 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com> <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
In-Reply-To: <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 16:51:31 -0700
X-Gm-Features: AclHuK-Nhf6TYTDNWSq0v6hReecRKBdo5ExoV8oZWGVCIO9BK-126Jv082Kq0QQ
Message-ID: <CADrL8HUZ3t8RdMEeBPfqsy1_1rN0Ty9B2c4iP6OzNS12te6vOg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> > uaccess_without_mm() is inlined into every user copy, including every
> > copy_{to,from}_user() call site on architectures that define
> > INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> > own __bug_table entry.
> >
> > Keep the NULL current->mm check inline, but move the warning into a
> > single out-of-line, __cold function, uaccess_warn_without_mm().
> >
> > The trade-off is that only the first offending access in the system
> > warns, rather than the first one from each call site. The stack trace
> > still identifies the caller, and the access is refused either way.
> >
> > Compared to the base of this series, with defconfig + KVM:
> >
> >                      inline WARN_ON_ONCE()    out-of-line warning
> >   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
> >   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
> >
> > On arm64, this removes the ~16 KB of __bug_table growth, while text
> > size is unchanged, as a call is the same size as the inline brk. On
> > x86_64, the call is larger than the inline ud2 and causes more .cold
> > splitting, so this is a slight regression.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> > NOTE: This patch is included for reference only, to show the cost of th=
e
> >       inline warning.
>
> I would suspect that the growth is larger on architectures that
> don't implement __WARN_FLAGS() but rely on the generic WARN_ON().
>
> This would mainly affect 32-bit arm and mips machines, some of which
> are very memory limited, most of the 64-bit architectures have it.

Thanks, Arnd! I ran some build tests on 32-bit arm and mips:

arm (multi_v7_defconfig):
 - base: 31,913,726 B
 - patches 1-9: +64,816 B (+0.20%)
 - patches 1-10: +23,193 B (+0.07%)

mips (malta_defconfig):
 - base: 11,830,177 B
 - patches 1-9: +61,168 B (+0.52%)
 - patches 1-10: +25,881 B (+0.22%)

I think it makes sense to include patch 10 with these results; cutting
>50% of the size increase for arm and mips seems worth the trade-off
of only WARNing on the violating callstack. Let me know what you
think.

Is the increase even with patch 10 too much for mips or arm? I can add
a Kconfig in that case.
