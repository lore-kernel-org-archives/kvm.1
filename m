Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B9388361
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351670; cv=pass; b=NWY7LBg6jeDvhGDo06tG8CsMkaqSGf4GK8LIzXTBFL+znHm9E58B7CK6s7Q2+pIYSGHu52pXMkRzFKRJkgST5nSPtk5amwbAxpki427HGuS0a4Z9ZzNjzgn+k6VFDDysmuihuZB0JYjN+YhfEIwf51lrRTG3bDQ8bUBPj4M/Z6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351670; c=relaxed/simple;
	bh=QTAc35LBPTpEtZFTnRHjoDshvh+YhheuGWUZ5W3IT+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdpfG5PvAsjLQK93nwLYVN4Nr4EoJj+jUrmD7e+b6l70xGjOeX/LESl1PBUwcZN/MPCL8oLaJ8JPxA5cDuxboxgDm6d0NJMMyYwUmkMddAM7RHpoMf1pcTt/TraQF2yT6WRcbvPQFE6aVbQE+qYzEt3H8C8w9hnF9uG3B+GtVKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEPm2uRA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEPm2uRA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so1124331cf.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 08:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783351668; cv=none;
        d=google.com; s=arc-20260327;
        b=DX5JJADvKBtucLRhZqfu7TRdMj8GRKqG3Tba5yoTC+cAfIGsSzrAjrf2rczB9tu4x2
         NhpAFih9RwZqDxMX683Rkbodvu5sXq0NgzSvxWehuWpMXOLc+uwioKVKTjBir+VgFdu3
         6YlaW2zjPP/m5HV+6m/BbKVKUJUqRqHGSneoOXkoeY77PIrBJM+WWKs/tIIz9JMwwAts
         hzIACCy6uE4vn4AhkqDIZVMRB/raENhzfHcePpSqHFlSCNLbOH3DhdfdCWK1bxkppCHU
         7gnK1uXFJWhB7wU7mxQ+3UgYWfrwfH1UWLwIMYQOuSa8n7VMqXfnV6LPRR8nH1qLWmmO
         egiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        fh=H/QUIKjRZUDWX4joXz1cPL6QGd7/5/6+azMl7h/znCI=;
        b=T/BoREeEl0ZTUkJe7mDK6MbRZ09VNJP5JihKO1iFwN2qNQyQC3JoDFckxSpuJeRw7p
         dLYjD71tY64EEJVpv/QwSaZ8a093sA3ktEFyBTkT1Y+ECzVS+RjcAFqwpRQ2qVvfdJ29
         DPUjGVGhgVW131rzQiSXZtXAhUm8DRaakyP2nmJKVlHgBqDx74CiCHHPzW6Z1HfCsLQg
         jfquAHVFQG72tNU9+dWgzHX7FUvGQpQwNj09KYesYNcn2Pu1GwvxVTZ1dQoXS7R43Yet
         4QEaR/Jd3Ct+urxgS9Gx6E/pvIaNddRmKifQAMG45XMa6OoCHH9fVTDraeNsz2xAdTz6
         4bIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783351668; x=1783956468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        b=dEPm2uRAr7B814fPOXVD945XC8OGpIzRjomioRNvjI8HChEDOizAGUyK2uvSOhRZsv
         z0C4m+9PApGVEMYNNrBX5JDov8WTEhT+0T9z70yZ7/x2Hi7x58V3UPjxF60OSovGIy8U
         9Tavg//DTSiBcwRRqsLgM5sA334+V1MtluypMfLU8YMDnbtQZo6xJhoFh3aIziCAQ/dZ
         l12Q1g5mlwM3kFsZ7jtqpDbBUeC4QEFwEbDqfEkc+XQuqYbNDxQoyT4aqx3OddT/cfM5
         y1Lmb7VZyDpC1FrPpafuNhOB7ULF6fOI8mOHifxfX16ttmiwAFotj3gMBjUaGKkP12rv
         d7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351668; x=1783956468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        b=mSZoWYgu7kQCLN+5IqTR/ehnL0iwMz45TgGAlbZc/R9vqoC4IRSXVxPapmQfHsRucE
         hoOjpIdOF9tvak/2cHOv6rVS0pGNuwKNCoURF+63Lp2ekyo5Yqw0+6INeKn8MjZ7uCEu
         w1eLMzRnBHO6Uerr7Ze9S7Xle38OnALj4/mt5EpxxCZFuHGty3rxqoaATr27zdLgpH4a
         llWhKQlLNLUpn5vIcPMhKu1Iz59m+3gHkK0siFgn0TCVqIptg9XF499TJTUR4uwgEj8y
         J0PNES8jo76CBqnrpCBC0owf/TY8d0IqGcUVN6FBKjUis2gSSA8KceKWraBvBUsV0i56
         isxA==
X-Forwarded-Encrypted: i=1; AHgh+RroYd93Wbkn/irIRDp2QDS6dQNE6B4Zch8tFx6YugWh6x580i4dfrFdOkvSzhhpUC6Jtvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGhr5pk+iJZFNmJZNcEHPOSWh12VmysipjKhb/m7IWdIFdrKZ
	BryA99lGhRsb1ShaPNxtV3DNoB5kICo/T44DCO5SF/YW0ghTcP+jKOtN9ocmR91re0V4XQaEyhi
	Byqqb2E+v4/xEQvvP9ouCTjRJafOIvDUtDVWFGwfr
X-Gm-Gg: AfdE7ckzuMoh03La9221Zy3E2cdxQg2LGBCh2aF8zMDuQ0ncy0yHBuGbPaBehDNmvlB
	QT/od00LTmQpzgFuLdnIg5gfEgNB+90GIfoqNvf5617Wv0xilSDo0SOONlcRK7iehyc3v7zlujW
	rye5PKBAZ0RfE1EftXgbk2wBdF8MtacpD/OcnemtgRMVQYEz0SKV6ocJlUE+UeAYhX/ZMgmyvVQ
	ciVbia6fuxgj2d7vyX8vp1eF56/N63vpabVHCL37NvkZxxXOvxv0hQKcbu7DtPZcHQgbcVs
X-Received: by 2002:a05:622a:12:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51c4c0b5e2bmr17981081cf.10.1783351667666; Mon, 06 Jul 2026
 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630141152.3757722-1-aaronlewis@google.com> <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
In-Reply-To: <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Mon, 6 Jul 2026 08:27:35 -0700
X-Gm-Features: AVVi8CcigofLNQ1bpauMps2t4CVwYArmvr2bOPAAIS6Cf2m4U9AathUI5NcTHxI
Message-ID: <CAAAPnDF4x0Ci56PGUdZ2-662Xs2mf6iA2AuWsc-iOe0mL57OwA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
To: Viktor Malik <vmalik@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, seanjc@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 11:57=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> Agreed with Alexei, this doesn't belong to the kernel tree. For the very
> least, the provided bpftrace scripts depend on a specific version of
> bpftrace (e.g. they use macros, which are only available from 0.24). But
> we could certainly consider it for the bpftrace main repo [1] or the
> user-tools repo [2].
>
> Looking at the code, I'm just wondering what value does the Python
> script provide. Wouldn't it be possible to do the same in bpftrace
> directly? If so, then including such a tool into bpftrace could be
> relatively simple.
>
> Thanks!
> Viktor
>
> [1] https://github.com/bpftrace/bpftrace
> [2] https://github.com/bpftrace/user-tools
>

Thanks!  I'll look into those repos for a potential house for this.

I wrote the Python script because I thought the logic was too
complicated for bpftrace to handle.  I thought it only handled simple
scripts with simple logic, i.e. no recursion which this script uses.
If that isn't the case, I can certainly try it.
