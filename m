Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123600;
	b=Baq3jKHPgv/Saw3RcCWjVoK/4sjR5YB5nXG6QytefIjTODbW4DzLLXUq3BqI8OMEuZLq
	 vzPDXBgtqTVmaJ+qCqSYbqKSwxGeN+KvUDNoXj40sla6xKbOpoB4AchjIqSWn/Ylvr2t8
	 WQl1pMmSTBD42TTHDxez563tlKTDTDQzchMeWI44lhm8jkUm3saztUb666xFsrNHhxi4v
	 b7axX54iHzuWX86pH/eZ0u1Aur7KHfdI6q1BPDByWhfw/cX+xfGgEJI1iYfqpLGTTDyE8
	 AMQoi5Wz4UvpupoSEadmjulX+1eBsWxSlEelmZpk+nK4wGCj32r3+kzQaygga/B/yXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
	b=1FC3A6cWuv+mfaAwowY4/EIKY+gI9nXkdp9A3M2X5Ez7q1HbGtvLI7pl+5c0ZIoafWBx
	 wcJa7v5+IGLrFNNPmYMynwaF0CL0sR7jeFHnqEnT7JHNrvRkmSnv9iU4oqK7eTSJlMXAf
	 uVma+9lO3ydRegbjGB7ku0F5kZzeqcWR2wQeH6DNhZqwD7Q+BhgKVx5InPiB65TCihkhN
	 NpNZdVXBDow2/fCSHnoiK5CFToeGuMJCM/6kjsS0Ntiy7snQv5cGqji0WNFg4/dufuef4
	 Z0xWqgMLK+dB4/Fcs8JQoWwlHE/WSglMA+b9CSmq3OI+4pSR0TyoNd+hspg3SGskhDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1291606A324
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1291606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4677aad67bso12560866b.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123598; cv=none;
        d=google.com; s=arc-20260327;
        b=nsLKodrhlOyd3xvlP67Zl96netW8Y/QP+f7ujlcPKC6vwK7uoBxHF5wS5MaEAQ5uXv
         ztWf7quPRXAlEnst8E4ck8Lf3vy8tggFwws/32vSPfrTs74z3CwGGWntYOYCcudPkSzV
         w65J+NQhxV+Plh+qcuUJg7FXNnlTosO1f0L/yeq9AQmVaCCtXuGm+n082ISHu82MDlFz
         345gQMMMBqdTgfEU+9GljezcVhKDe2XJMS1WyVaLK6GbWLShigF8BpDuvUZYlDSb+NMH
         C5UZm4VuMS1kjNHgeL+B2EyXaN1cjonCXJYHr3GtKEdwQWr+X21RP2MgEn4bcDvDLG21
         BjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        fh=0cLyA427C99nv1ueexIrWJZW4mOxwX12aho698iISJw=;
        b=qiflgVdL1SjeAg0kc/HUwvuRm+KQceY6IYAOrVoG+pMiCHHUvV28r0isjLQmI4SviZ
         Be2yo5wb0aCTaSG00Evnfh+iOC8YC1eh3DHXh8Ju6z58hRBHQ2VGWbsi9kZtvFx79TRn
         3a3HYNyVfmY1c+UY0N0xgvYcJ1o6reK1vtVuic8FzDW4XEqlh/ax249vkXu9Gjn7V8aG
         c67Za6i2RJVWi2A1kuP4E5zK1jzyvr+/73n08Onn8Z/1+9l2iaxFYIA/8ZVc95oX8CTl
         PJxnwSrzL0hTpRjYZH9vcNvnI4xXgFcunDlrsS/6Gr04Dy04Anen/brIeXcOkyU8fyDT
         Uyww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123598; x=1793728398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=inJR6ox6aQPgzkJ0wZYiPBugaLW1/kUDoRUxznaXNPrxE2Wn3DkQl3afONPaEwO9sl
         vnrt6FP9OFfRf9KWlwZNng3ZlaCrfp3bQxPXGc+Gx+AORrKLJ8WZpN9m6kJEM6IAqHPq
         Jk4iMXPxJgkZqxRsoYIxQcD6CPbdcJbwTT1mEJs9Oh6VfooqjmJi5DvsYqRTbZ70S79m
         W2gdT7rvplj4k08tnzQQgxgOTLo5uqZ4a0mScYBLYVaYMXTVeZPwvd3azNIWeu6/sXO8
         zyeS5P1gD5N0vXZJTHB1IRGypOyTZEZWjLyDPXDDqsHxY4MhwV784zCuBQDBJ99Srvxy
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123598; x=1793728398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=wUsYlQpTp3RRkcC8y8Hc9Ry3lNp/gVDATJhuH1nidWhFX45ExTkK2I9eC8oPYTgh3/
         MwRvUF7BC7HMy603Tat6fSX9cz9XKjoMWoshiP65VplsDlzg6F41u9oodL3PXw56WuRA
         mBvMtbI0GH4YzWtxz0Happbl4p2RNGlpgy7gltLYdJYSAOSyjkcdhUtyU132CCFgKiPo
         7Dd8QqARsv4AB9/r/O5djfIgmd9IHUtm72GFvxv/tjJdpX/Ae2OnMfwMvLtUnY3wlO4B
         +lmov3INj9eKwir+foqyw87TzDhF1MNSN9kGABdL44WRc06UoS4pvr/mp+5P7jDURaLU
         g0JA==
X-Forwarded-Encrypted: i=1; AKwUvBwwLZIwXpznn4V2ZkRkQOfSRkAbeX5p+3OZ/y1E0WlW7gFYSQFoO1mfEOzAot2I5Qpe3Ug=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwC80VeeJznxxtmorL+ePz7jV13QCl35vdiXtgnF2U65GGv1iQ
	B6Ikqx/bLhWW6Ylz4gjH+OhvGqiWLvcHNeGRFNEGVN6IDbdKSA9c/8vQgGNBUUjULYJ7F9/uBNF
	viwCuR4EOvng30slFjwhx3Bzs4v7JGUDZ+zKYtJ0M
X-Gm-Gg: AYBFou3VvJUboYZ6yehYmzg7igPg/ojFsgFzzH1QVzD5F/kBaJCk8Bj3mycOqX3zLzQ
	seZMiZS9sP4wwd3e/QID5KyEsGmV6LskJPeJ0CjyfqYtofgaBDq3a4EmTJ2xIWdNVYtbNmSyLB+
	vHfC+hN0TwrRA68dPyB/Jed51qKsnbK6Z4LQ3lTBCJanIU5E4lfoV9ZK7aVFr3t67T4wuHu8tDQ
	QfnEso6Fz1ABCTN8EmcY3a22cdyt2L+T8s4kt9qX4MGJ+XFTanFDzVS2Hz7621vXmHADTSC+q0C
	v1TFpUQ/wJhEwt3vXEcqAMWhFq0ISVDoWl+P6/P4LuwN5T7qFhKa32EeNAX/p3DHsTktOSk6Q3A
	ItcfyPb59kmLirHzaT3ewrwYoY4ODeoN2xEDJ8Ik/7YhoSaK3Rbj3sDKeU6x8lVwnM41UgVgzws
	aGya2fX6H20RyEI7jwNci0jwLN3xzJhXipdLUXYAAOYTrFuB0w6ddyPVb8ulmrQLK9PoyPAXCPf
	rsbkSLd9La45w==
X-Received: by 2002:a17:906:dc8e:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c46bde8b464mr1159692166b.38.1793123597614; Tue, 27 Oct 2026
 10:53:17 -0700 (PDT)
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
 <20261026215226.3713941-2-jthoughton@google.com> <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
In-Reply-To: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:52:40 -0700
X-Gm-Features: AclHuK_7gnb7g4GjAy_SA5zcAxXhabVZixR-oCAtO-qS-tkfEqOEG_LlV9pvyY0
Message-ID: <CADrL8HVgOYb1hzWDJzm4sCrEAR7PL1xBv-1zTGebTusPoDsGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
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

On Mon, Oct 26, 2026 at 7:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, Jens!
