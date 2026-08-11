Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944A36D4E1
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479708; cv=pass; b=fxHFgwI7dQbC5VAFDwZcwyXfvZ5fBV28OkIGBdy0faLBokSoQuMPujw+nLFd42vdFHzWjZivTGUtmu/IQM2AGQr4pIyOLiK1Al356J6DJbND4p//lGl23Bo+3cuEfE85D/EUzfambNrmHWwIUothcGWMGnqlCST8MQU1G/NY7Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479708; c=relaxed/simple;
	bh=or5I/jgV4DG+CHbwj9QFHKb5QkogaftlErhfi8b8BYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmY6Hcyj4XRFFD9iBZfFX7ii1zyX5rMU1iLqw4D6gUjYIhE/e1hpM9Cp0tMZuaVeYx3i6i9AVJcC47HdhEqeV+XIBzRKi/jUs2gJTODxhGwYX7fpfE25xBvQfS3xIqEpdVpokOeQJbljp/JzlBBLf6kHi9tz4pNHGy61Hxa7EaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAkD5Os+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G05gr6Yg; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAkD5Os+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G05gr6Yg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786479706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
	b=gAkD5Os+WMGaBQOZIbRE6Bwq1ymT+rqawxtgZw5Sxgx7ckgQWCHzqQLOU6rJTigwh7BOHO
	m7l0tbNXUUguYsdIbO3apzhbWS208/FyoFs+sP2oWsNeGypBrhsgCKvp3Wio1h5Bs3rr0A
	LnyYBdM2bIROXLcIFE/opneBVXc1RwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-bFAg7LM1NMmdBDh3rGi98w-1; Tue, 11 Aug 2026 16:21:35 -0400
X-MC-Unique: bFAg7LM1NMmdBDh3rGi98w-1
X-Mimecast-MFC-AGG-ID: bFAg7LM1NMmdBDh3rGi98w_1786479694
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47407691804so102751f8f.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 13:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786479694; cv=none;
        d=google.com; s=arc-20260327;
        b=r/je+4/MTw94OiuUIfj2esW6Ocdk1EvdGy1z+TEO7kTg+BQDGbGtUuQBN1eLT8agpR
         iPIGaux9URYijmadwkQ/7FHH0Rqf86SrWx6XpjVTswwyT+n7mQzFwQDN6u2kRbfXEMAk
         wzzqwhLsjFhsSDjp3EQwgDhSRJsSRMzeUThkq9qQCmgVunBOlT+V0QvQVlf/ItVrsOYB
         C5sN7WCLqLW1xu9Bwo/pgD+t4CCZPxu+4eXxAFZmzePuD4bOiLpjH8I1j1pySF7UFYMJ
         SsQZYoHIla1fqoht3RK9XAjdr6TinF0vcMbbPfrK8R49QbKHI03kKifNCHW0RlrjITLi
         v/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
        fh=8y7clbUsAQcztJcRAdFkPZlpXAAAYey8BjH/0MKWB1E=;
        b=GM19Cko+MgYhc3OncJ5qJjbewB8ZfBzxFEYkzvS09nEgzOr7iqvH98QlGrtHqsq8Rz
         0H1V6dhlTyRQV64iwpe/QdnwzsSuHWneLgPommSR1TJI/C1mlfcMS0hFfdkPSC3zmu2E
         b8CYip1Zz9fzRozPnNfH+u+HBguJbp5q0EgQP8O0iDLWyIw+3JvCdlEhgtHvG75sZQcb
         jNZ/YUr7p8nBI3UlKuKk3TkDqOKaw2CJFNNho6vrqrAqWjvDsE99Y4ekbRxYkGCg+LgD
         cJ1AJyrFEaxFIo2Juql5TqHhlX308QXH6BLFwLZRUOUEdblDkqJ23+O8GIMfhoKmvGf0
         ujxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786479694; x=1787084494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
        b=G05gr6Ygq24tiTAJAzLZKhe+iQZI2xFpTKQfBIEuOaSQgeDIqohXzL7CwvHzpCyYOa
         T688+CEHsJ7DEAdx4ph/K9jFzEhXWkwi+N/CpZnnxDVQMPWeAgm6aa4xWcUeY7JpL5Gw
         iZqXaUwax1fRO0Dck+MwWpo+6jMQ7k2HQwWCCKabEz+pc0+9g0Rp8K6hyrMx+LwecYz3
         wTqdIYbMc3IvFcbeUUkhOSyN5l7yRKkfIX5mgMJhh9DocdrwTS35rODsMYTgm9/tM7K6
         fBbAyEPUiKeW5piZSX8awSntjidlMxu6JAW5Y3iaPpmOYhAjLIXKsz9c3jiQp2XsjVW8
         eVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479694; x=1787084494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
        b=SI75h6hJZGOUNqDzjKG9LG00M9mGseiNGGBsK/TOfYROo6WcRfMgTttgnHmAeBe4sD
         claCzDVvtjntFt1df7biTpkIo/Ms+Cd9qLoQC/ckkGdo4DQEwRlteodWdRe8RFfR3GrF
         v66O6jzQYLccjJMsJolLfIGCNP3PdL+N5mRGm9rfZkvvbXBh3aLUknexGdRczXtFb0SJ
         CO99SJb08qkwhDIiGxFtukWtUuC7HoZbVREb5fEREbTqvcs6cKK+lQHvyZxiKsbQ35mY
         t13/UFLUwd0WF753MNlOeAJBmzQWVJilxASsHO1Ew4xNIo8prbcZ/y0Su8iCXOXvPfbX
         M+4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpMt/OTiaTY9LR9zkdnzMF/HNSEofk8HHWdlVMNZE0HqDxNj5sLd5QLboJGvSkyvcNnblU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBP5hp3RfKJQCTpM/YQjW3hGnnAYgW/nc9087Z+DyDUQeoUmX
	ZPZWLBI9OfvhDnV56hfmQdSuFOiLAaGeYOdCPzEhpnQaJldEB+5BgAMItYFpK91ZHIB4JNWGIH5
	arjGkb6cfF1qMNvxpHHBcX7Jk1cujC4hzjMfysjYCmUzwtly2ffqO/wVgu4m7G05vekOa9iejug
	3gJmknM0NaEUsn5Ith7T8rfH8gR0Kl
X-Gm-Gg: AR+sD13TaYFhu8m/2lT8YTVUW+OF5dVU1aLlI/SuqjvqR7Kqtnpn6m54dDT0Aqaw/WP
	eEyuYxIWeHvu/5uIuuPxU4K9Ndz0g898IEolCkUUXL7HECBaoYrt77gQBNu3dOCVTfYDef2EYq7
	3ehEUWpdd1O2ViA//OZikvjewKME1rJOb0S1q00SN815eZ5/ReE6+67Gx+Sll7b81mnqhlqosBU
	6K/Z6k+AtvERMYUy5tjCOZCJbxM7O2z0JoHVqrrXNydjtqiH4GzPOPlYDc=
X-Received: by 2002:a05:6000:4011:b0:47f:97bf:d891 with SMTP id ffacd0b85a97d-4814ad755d1mr8659623f8f.1.1786479693827;
        Tue, 11 Aug 2026 13:21:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4011:b0:47f:97bf:d891 with SMTP id
 ffacd0b85a97d-4814ad755d1mr8659586f8f.1.1786479693441; Tue, 11 Aug 2026
 13:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca> <anuAq2s4mtyw4_Ql@google.com>
In-Reply-To: <anuAq2s4mtyw4_Ql@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Aug 2026 22:21:20 +0200
X-Gm-Features: AUfX_myRxh8LArbRwhhI2WDXN4cv5LNCX8fqVJeZG8bZ6cm6DTva5ox9mCkJIi0
Message-ID: <CABgObfYR+vXBuSm3v5jbbZL8vF=XnocFAnjumdShgXBzod-HCQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, akpm@linux-foundation.org, 
	david@kernel.org, mhocko@suse.com, rostedt@goodmis.org, bigeasy@linutronix.de, 
	simona.vetter@ffwll.ch, jglisse@redhat.com, christian.koenig@amd.com, 
	paulmck@kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you want to avoid global contention on reads, you can trade it with
for_each_present_cpu().

On Tue, Aug 11, 2026 at 10:06=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> +static inline unsigned long kvm_gpc_read_begin(struct kvm *kvm)
> +{
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       cpumask_set_cpu(smp_processor_id(), kvm->gpc_readers);

per_cpu(kvm_gpc_reader, smp_processor_id()) =3D gpc;

> +}
> +
> +static inline void kvm_gpc_read_end(struct kvm *kvm, unsigned long flags=
)
> +{
> +       cpumask_clear_cpu(smp_processor_id(), kvm->gpc_readers);

per_cpu(kvm_gpc_reader, smp_processor_id()) =3D NULL;

> +       local_irq_restore(flags);
> +}

and then:

for_each_present_cpu(cpu)
    if (per_cpu(kvm_gpc_reader, cpu) =3D=3D gpc)
        cpumask_set_cpu(cpu, gpc_readers);
__kvm_kick_many_cpus(cpus, wait);

Alternatively, there's always the poor-man RCU using an rwlock_t; you
do read_lock/read_unlock as usual for begin/end of reads, while the
write side does

   write_lock(&kvm->gpc_readers);
   write_unlock(&kvm->gpc_readers);

in place of synchronize_src().

Paolo

