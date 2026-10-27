Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123182;
	b=h5ybXe19HoaRFouOBQWwGB2tsXFL83W7G/vpqKMyoy+vewxPAj+gtEo8ZGpSWEF/OLhu
	 j3ToJcIvTuLdYtV4F19atvuv3fDQtKEMInf+IshFTvnUKz1AocnGO2PpG5ZKtfG6Aa7pN
	 aYDuIn/OhxDT5gpUUi5+Yy8+l8Z4qbrjyEEZqXHncR1XTc501v0hD3T6xo4YLltjAu5AD
	 5NSqgimNXqEloqMnHS9vhrSVzG2+99ya2k1nhYCMmbXuS7cQZ2eqB5gFDXG0Qh8M1TwgR
	 yScBVGWIfKN3AJKPeH4lvV+SbAvpLRr5nFINrBfAiNF5FbWxztyZY0BZI4ND50Bzzbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
	b=CF8q+SEEcPhdseKhahKVl1BxP9+EqfJpSRBbjJRzadbiVwqHCTaWRMXw7TQDWLc1JO/0
	 Tgx5a3EvnZDn1NR5oGs3bWGt15fykPCBozTdRhvRPpURhhttZf+al5NnijQ4XqKLcEshm
	 1nUDazGk5bRhGNFn82/liIpa8vsNckpa0BT4Z3YO2Jagm9QRGGvy+LfItXHNtG9l+KNxR
	 OQKr7FqM4dyBfYY806Ocs0nE/sRIIHLqUX4HPq+7r5xrhLQ9PgdSDIowHrP3PP50ML880
	 gJQfPF/GGA7GKd0NYB6v717pzOqbsTHIioB9ErI7DyxeoV5BXkwDso/dN19oOJrMscw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46356606A323
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46356606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4550d8ab15so10973166b.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123181; cv=none;
        d=google.com; s=arc-20260327;
        b=OyyzFHYyEjr9m+eZe3pDYtNZNwmOxFnwDxFuW4cqlHufRqXklK/aESW/XcHD0hCjhk
         7xrOdcVB1L51m5qmOiURbWm8kLS+MhmrwK00Mmu0U5uN/HoaQ6irYRwfwWP6DDJ8TX4e
         7Z63PteCRDfZefGT8GzqpT5+2CQ4ddQHjTHpMld0mVXph0SkSQXEUHZ8+1TKnWQ4lO31
         QYM0vTT4hMrIkgBKSkS86n7I+7gNBvf2W4KxdY3aBVnD4eyjVnTd3zsxPnAvnnD+xT/a
         +b6rM5k8i/LZzCkDoe2V9OMBrjVbBeYU0DiKCML3zeZP8SWt3i9+h/pTRurY2Di8aFGB
         21Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        fh=hu6THqTOvDEkoUVOv/4zGt/1hG7HrjFIgctt1acPav8=;
        b=gtLx8SN7zTxPBSkEzFhJ0/ae5GYRhwGNSDUaAfP1UrmvhSe1rZbn09SfHD0HoYHLwF
         8peJTBvz62E2JNKHfgTVAxxVbnFIWAaNKRrMOEg9gNfKFsctZcV64fZMAFf24THz42NM
         hK0DKXvwrp7HpzORAkXyYjKp6mg+58ddq5Az853JzrAj+SISxuT2ly7iPI3/NWDwpj8u
         8dCq6E6TER+IhJqZTHVzrOmOw3rmH2sPtCChrK0S4tahh0qVL+4FyzoUKhnY6dCaWk/P
         G7QDdgzkWszm3ATNlGKbwkc0WubxBDl8Edw33c/iE8ukrSdkUFIHoZO6XriaZoQJkYRW
         cEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123181; x=1793727981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=dJZrWgbceCcvybGI6S+yBWHGKTnRTkeoo+QAXarbXhuJJrcuUxjX6DL3VJxyeJguO7
         EIXUQuToxD9Oj2ADRK5huhz3YAPfLd6CErpWQOPm8uk8bar6rE79bi3bMLs3pZe51bGu
         X4MzPetzpkt4sIfnqO30iZNgo0TbdVmPtmqopEkvLhUnsg2bhmTSLgRVVzhYHy701dNf
         Q0OtvKJRnZ80/E3NbSjyx0npRgDvtmNSPb01SZjgkwzglNyd+xHEbqih3MUFsYvHWiHM
         BQc/ZWywC5lvAnEYkPeZz4JTWFyCYlKLP3X73YxsX8/hg+Ad4REwmoFnONsNmbYY7MNG
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123181; x=1793727981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=X86/dnFjlASemGwGBFqiSimdckxfOuxJExOFWt/9lDuAUk8xSnvDdQccFw2FnRizgN
         Pm6B/GRG8l1+07TqtlNsasdeiit9HTTtwqIJ38FwohbjOyFFyL2YvJ9q3KHCzPfOxbH4
         1QJjnZHBeVxLzr/ofNQGljwmCJ6sn8Juu+yTj8ufTJSpfOy08x41ndzI+rcXWIwsZ79K
         P6BYGukMkL6QIPhocqxXtaf+tOGPQH8O2anzM2VUkT338jT89JIad5BB1I7gm/bKcM6v
         nR/hqpHSIpawC/gfpl0jN7gyiIk212WsYo2XZDS7fvUGEZh4eg1U+Q7afOI4WdqB3Izk
         K9iA==
X-Forwarded-Encrypted: i=1; AKwUvBzSchO4E9IB03XwhLbyI0BcUAv7deaJ2/tCEwvajCp3avuhbz6LhS7qzDa6cD/CGVXsrM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd4qbm6+fzKmlwi4I9oOFkUstwNsu4fD2U6osahGjMAPVWkwT3
	E6t1mS8sF/UgMa85AVJ0rhaXrqBiE81cXXAYrIcihFaVZLWMmSXsvmLVBZomakcBR/ao0Pr9VHN
	XXxKNyBX/JGGyQmQu9UlENEzMdgTsDowZmDBUhyDc
X-Gm-Gg: AYBFou3ZqbjSVnlq+A8KQ7/0OIbzLE6Chl7nVWj/i+Jy7AZre2IqsgmVfrHy0FnD6c9
	y1cG/prIa7PYj+jTkGkwdSSmes5wrr3VWkWGFCXOmtFChFCO/J21gNxXc2a2RuLYyTlQxii5BnO
	0Xp94XfdioZxAA2WeeNigy6+4BjfZ2O5z2s3Z2hgFSi5hpn3HucILi5LDn6KOPuzjtSt0bafcgw
	AYryVzY0kG9dvHSSQjT1acqGR/NJWt7US8POhPcotSGbofLN0TBHbKPYBipur/9bYxf8z6LtpBf
	mDyB0hLECIKXmPiI2i4Qqktl0QnpCU+679qwnyWAdA4BxRPBp+UnCsfOwDgJ3dLPhNyaPrny5Uk
	8gnYyoZvLLcrNO7vk1qSOewOtOWmeYeGE5MYKenNvmCi/Tuj0m5A5zAiKFN0p1dyMjdPpaGPkc/
	MTh+meU40Sq2WRYlmShgXEJINSl9fauy3Ek+tHVuYykkBcpLdqzFrcGhNmCz15EaJcgsmYzRcN9
	toMygSFnaNFXLRORqRwjQ9rUUa0V3qMIA==
X-Received: by 2002:a17:907:7b9e:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c46bdec03f8mr1197886866b.47.1793123179946; Tue, 27 Oct 2026
 10:46:19 -0700 (PDT)
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
 <20261026215226.3713941-6-jthoughton@google.com> <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:45:43 -0700
X-Gm-Features: AclHuK-GDZyG6m8BFpUMWxfSIBXFJlvlZbCjTm5c1oLpEFzow0OEe9cdwDWWw7s
Message-ID: <CADrL8HXtBxf=qixBZV5-iz1sqfZAqSrMR4ZsJTFXS0N84G+nkw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without
 an mm
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
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

On Tue, Oct 27, 2026 at 4:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 26, 2026 at 09:52:21PM +0000, James Houghton wrote:
> > get_perf_callchain() only checks is_user_task(current) when the regs it
> > is given aren't user mode regs. However, BPF's bpf_get_task_stack() (an=
d
> > bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called =
on
> > the current task, which are user mode regs for a user task, even if tha=
t
> > task has already gone through exit_mm(), e.g. when called from a progra=
m
> > attached to exit_files() or to the dying task's final sched_switch.
> >
> > perf_callchain_user() then unwinds the user stack without an mm. That
> > access does not reliably fail: the user half of the address space
> > belongs to whatever mm happens to be lazily loaded, if any, so the
> > unwinder may read another task's memory. This affects e.g. arm64,
> > riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> > current->mm itself. perf events themselves are not affected, as
> > perf_callchain() already clears the user callchain request when
> > current is not a user task with an mm.
> >
> > Check is_user_task(current) regardless of the regs' mode.
> >
> > Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  kernel/events/callchain.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 9d24b6e0c91f..a451ca2a5573 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool ker=
nel, bool user,
> >       }
> >
> >       if (user && !crosstask) {
> > -             if (!user_mode(regs)) {
> > -                     if (!is_user_task(current))
> > -                             goto exit_put;
> > +             /*
> > +              * Even if @regs are user mode regs, e.g. task_pt_regs(cu=
rrent)
> > +              * passed in by bpf_get_task_stack(), current may already=
 have
> > +              * gone through exit_mm().
> > +              */
> > +             if (!is_user_task(current))
> > +                     goto exit_put;
> > +             if (!user_mode(regs))
> >                       regs =3D task_pt_regs(current);
> > -             }
> >
> >               if (defer_cookie) {
> >                       /*
>
> We have perf_event_exit_task() before exit_mm().
>
> Still, it doesn't hurt to be cautious. So no real objection, but perhaps
> adjust the Changelog?

Right, perf events can't get here, since perf_event_exit_task() runs
before exit_mm() (and CPU-wide events go through perf_callchain()'s
is_user_task() check).

The case this fixes is BPF: bpf_get_task_stack() calls
get_perf_callchain() directly with task_pt_regs(current), so a program
attached to e.g. exit_files() or the task's final sched_switch would
unwind the user stack without an mm.

I've added this paragraph to the start of the changelog to make it a
little clearer that the perf event case isn't the interesting one:

  get_perf_callchain() only checks is_user_task(current) when the regs it
  is given aren't user mode regs. That's fine for perf events: a task's
  own events are torn down by perf_event_exit_task() before exit_mm(), and
  samples from CPU-wide events go through perf_callchain(), which already
  skips the user callchain if current isn't a user task with an mm.

Are you happy with that?

Thanks for the feedback. :)
