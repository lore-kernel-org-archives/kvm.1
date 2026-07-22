Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623103603FB
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762399; cv=pass; b=tnOG7haC0gE85INa+5dp4+rbW1ztugJzYqfRj5kte1e2GnukpNpsmHGBcyOpH1wn8zGuL8oFnSe+Ok4/iyggvSOXEa/2fQh/vMHTqUfcZ4FVbOHzYxZhVXgN+cKMRTVX3EF4C9amKHaTJypvC2F/pNH0fBYeN371iZeHNmd+thw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762399; c=relaxed/simple;
	bh=j9MJOToLYeSUckVrEVh49X3KxvSk8fX8MZZByB5xYzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8FQyiNrWHSCxnBG49ZTYhEWCKlEI9VEPx3cx8fGsVoQ2+p423WSD/8prD/JXKE2/WETpwm4xMWwOHy2pVjfeOl230wq/SyhmwFlBFE71dBXvNnwQsEqLIF0nogeMZQA/vvTk8DZgeiGRqWIUpNd1LNTJe6Jvwr6KuGbjP6VFlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahyOjP/e; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahyOjP/e"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so93651cf.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784762397; cv=none;
        d=google.com; s=arc-20260327;
        b=Q40zjjiwgxApsHvkIfZTur5dORmQrTKaZ/ywJEwm+JxdJWqXIK0NRRWd0wGAnvSi8A
         UnmYt7vtH1BC8yc561QWPz1AumXy9O3LmzjyPFygme4fXClBJ2cFFGpFKdOMUom/z6ke
         8/+jA27qeuGFyJs5LacuZ5S424829W+VU0wIGGpFMWVcDchbeXg9E72qiJ6dAmvzSw5E
         TL07MCvZ00fUJ0wOBemy06qPQn/LXkAznWucl4/kwSm3pMJs1W99z/OgUEZpc9eqhpVd
         ih9YCOM3N+pTkE9xrNfBm9MiDT5R0T9SA20TNrC+8dGvty9y5LFjcVP62hoO5kzNxJ/J
         hqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j9MJOToLYeSUckVrEVh49X3KxvSk8fX8MZZByB5xYzc=;
        fh=8Adl2b+3DKT0uOEUozd3rMkhXuWDfiMR2OK08adVTX8=;
        b=PEQeYmgDwCrhQP337hfa47mdcXOmSLID38pj3D6gDXzURAR5eDn9+Gj54Lh6131qeq
         nsDA9oTqtv8BL2hjIzBigfZnrLPYYzEYCmyHqWaO+MZYP3lmW4PZumdasZwLvpsHc7hL
         2qEhcaNbIEYpoTTV7mJ8kasj20oPXrJR/GIJKx+M75XDcAZ1A7IBsxlhx5yJGL+WJFfh
         4V8hxEvbHYM0/ll9gCKscL9/aQWYSXTODeeYsq7PnbgFmuAWchf5F0CtuSQPebcEIlit
         Zym9PnQgj7D/X+r5TqNyywre1ye/Zw9wvgDhL2ZhyhCq0Ov8gQaifGuC7tie1K9J1Igq
         07kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762397; x=1785367197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j9MJOToLYeSUckVrEVh49X3KxvSk8fX8MZZByB5xYzc=;
        b=ahyOjP/e/u7n1s2K/UV3GREAqt0Eui61Gdqv87iCfryl/kQWVfP8xA1rMICnJ/4naP
         ppxXbgfNmqHvK2mlqVlJ1sFl7SplhVGtAVGMNnIBYMzrPJCyeEJhNeWgAh8H921wH0Gy
         DFd0ZI87pXiFgrE/MEprDIuM0BxODvqYE0NBwqTmYTFB8UnEjFDg2AqLVCt9zXGox8f6
         27dESGQ3hHeeRUPpEgcDlHhC+LLR9LxygA/xf773+Mg+aoKBzfwKCPZWXCJjOab1OL4Y
         P+smg1w2KROtY5DkyGlBO1nJ5h4q54PVtxWVH6cYJ+TBMoFjjAmUJchFkQOUkUIahT6S
         vbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762397; x=1785367197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9MJOToLYeSUckVrEVh49X3KxvSk8fX8MZZByB5xYzc=;
        b=hGpJ9f3zz7QjP2Ixcqbh31Wfh5TlMrPb3MYBg3yvL22vm9TQYxGnd1p8CI/+szEXCA
         gebA2Pp+f1+6XxWr9/k62AmSpEQw1BXpoFV1KdUn3A29yF1Yk3oC802OUwdpVmhDao8j
         B1LZX5u2IVP56BWvs+Di17Cmof736niBo4Arq+IacwanyXiwxz/DSyFtHKMEbymb1TNp
         icyWErtHkdqwloRjvA0O4hUau6dvPbOFPHaRmUjsPf9pMGbvpAb3dMr6jyAIgSDCFmNK
         NlreP49JsVnfmqRfkFSdYoJ1CjrZ1xGYk2pQTfnyOynX3iurTVwgYyYpCOznNc1dglkg
         CdlA==
X-Forwarded-Encrypted: i=1; AHgh+RrOh+4K4h1tjaUxx8iEpfs59TV0ceGo6MqPmcsMeO9TUNvEu/w7RWpRo5t8dJDq1b/hZ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wmFZDDpMyI7Uz6oYphBwm4siO97A6lB8xSp+aDARG20g8/ZE
	lef9MkEB92ais1Ow0pOdf0yCuVTGpOxXyoE4fB3oIbYgRCF89dgxvfdOnLmBEbAff5/C+1Qzzxi
	V4fzrjj91m5OfN/vbXXJkC0VF1nBp12nypTwmxe0w
X-Gm-Gg: AR+sD13LxVFv5KqNdH9yk3gIEt9TYP/in1o1NpDgEYiEOUvRsYRKZEU20DomWeWCap5
	td6qDrgsdE9HrOOIWJvPDf7gSxA8KFquPBMRp64VUkivRaxI0p8rUCLJKR+YuvvxJyVJPVSqHXq
	Q30Ib/gmdVTHTFnXbElIgGdwK/tCNLHo5gcTCxiNH9IvMqsk/s+huiyXT57L6QbYe7Wny1t7rXW
	auu0Yb40ynCvP+IrnKBbm85MAw5HhzrMVi1VlznS3weVQG6ZwzBC5e19yz0YA==
X-Received: by 2002:a05:622a:304:b0:51a:713c:7444 with SMTP id
 d75a77b69052e-5283bbe63dfmr4028241cf.18.1784762396351; Wed, 22 Jul 2026
 16:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-7-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-7-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 16:19:37 -0700
X-Gm-Features: AUfX_mychJO85hOoF-cxkaq1bYVGm3V8JkwyXrESvHjTXrLF8G52GUXJzSrM31o
Message-ID: <CALMp9eT+jJbTFg+LOjyWJYkJZDgQGDz-z6s7TK-uSZmRF9JKvQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] KVM: x86/pmu: Move RDPMC emulation into per-vendor callbacks
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> The current RDPMC emulation splits responsibility: rdpmc_ecx_to_pmc()
> in each vendor returns a kvm_pmc, then common code calls
> pmc_read_counter().
>
> This design cannot support RDPMC reads that don't map to a counter,
> such as PERF_METRICS on Intel platforms.
>
> Replace rdpmc_ecx_to_pmc() with emulate_rdpmc(), which takes full
> ownership of the emulation and writes the result directly into @data.
>
> Also drop the redundant bitmask in intel_emulate_rdpmc() since
> pmc_read_counter() already applies the counter's bit-width mask.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
