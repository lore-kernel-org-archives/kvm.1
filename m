Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D530BF70
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837399; cv=pass; b=uBg7CmrxA8TEJxY8+V9HcZOgbvOEAq5boHKF/XGrntaxVxIM4nbffJxTU0CuszdBoKlMB6yMdQAEBpoFtaxU7kqsLxHBA3OibmoZE/l5F8ueq0NF5mC4tvzZ5/Qr+9bpNXgUajM2LdrX81syvIMv270AN8JXDhNyEA1bKZZyQPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837399; c=relaxed/simple;
	bh=5f79PSE08PBkaNMafHH6+G/l1zxi7gn96hpXQ+wAxkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQtR78mjSo3TeQkWpE9LDPSulHH+S566hMKJ77ZaY2AVdmpEpgJJDd3hFr6yA0ZijEdh3xUlvwRK6kcMvVrx8JjXh73OwVI84tpQSqW2QBGuCeK2QgIMOcrPWM4clMeeEPx1Dj9bElH73V4jDQuMtCbE9099DKr215AyPIOKoNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6K4U0QN; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6K4U0QN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so205931cf.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 23:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790837397; cv=none;
        d=google.com; s=arc-20260327;
        b=GovgBC2DbuMFoxhpjJKT9K46L/YKjAuyyNoV9Jnpv2YtXgax1o72a1eytiL7POz1Z3
         gfhg/bqYPfBZawYRdWafFj/LrES3QmQ8OWEl/chLnZFp0SDrgtWwqi9r9XcDb8ulQpHK
         fNZpOyJDwdWuwccyvAJLjRwWkmwBWHG13oUZ2hRYMVJZ5hF8xRKHfFKCkTNbbcbkvqo2
         6i4asnKBkoyii+W1VqVHhO+KK0EE168QGdmGFAblV9F/COWAzgBRGEFSBSLhf+WAd+pC
         F7rU/D4AW9JBGPsMeqMV9ViMo1ynVm+3ZrtYbR5DgDAkMYdA7JOoy+fda8OjCJDh4yE6
         luEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ANNww94QlmRaV8/wIkBwlyMEyhmACv8DyF59iTSMNXI=;
        fh=k744XNlGxvRge33o8MqiyX6heQPgXoRseKHjaQfteDU=;
        b=kCGGdCzfVx06KZjhv+wSLrRa/0QUxdnZqKeYRWTxa30aa2pPK+yR/ME56PzHKwlX5p
         zA9YcrPVUabY25g9wEhivPud6QZ/PfSXH8kFT5yZpB98VQyEn8+YNr8FDXH9OyOVQHbq
         YGthhIjAvwMDFkm0UXHJ0yspwbsg/JvMfOchJk4mDavptBoHcyKkElVBdq1ugtMBGTud
         XyYK+QcWkjaZA/jB8dT7zWYXZmw+4yNgZS+Rh0otjxAcv1QqFundl08i4V/qrLyWhLD6
         ldyMmwL5FP1Q7FHbrKF4FRp9eBDuGDPlMUY+EfNkAkVhKVVf/TYnIdAt5vRG4VJOKe76
         xRbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790837397; x=1791442197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ANNww94QlmRaV8/wIkBwlyMEyhmACv8DyF59iTSMNXI=;
        b=I6K4U0QN2Ljw/5oUVVipsqXG0s5QszP7HoZTRF+5ITMYs01+2RFqxjLEgpJOhzAjoe
         DeUxLq85iUaTpzM8dv2ff68P6KSUGPz9bzu1L6sHNMHK93vSCnvPI91nIrmFIBZ2jZ2o
         yUGcoZvdxhUn6Pjk8vkMmGI263FuPUFqImvo2vcjP5OWKjIy97rZBSWxdAYMhInlkzvf
         bHH1UQpHUe5WyukQJ5P8hlYWK1d+yuczz2c/IArBKARCidWicyNzmqNviuAeMDhYBWJc
         aSh8avANt+aM+22KNiXUkz0odtZLYlxBLjdgdCG3xnrbUxmnja+gF12EMwNL25gC6FBf
         CtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837397; x=1791442197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANNww94QlmRaV8/wIkBwlyMEyhmACv8DyF59iTSMNXI=;
        b=nrAB6FNdi6ll3aaf9HcZawGhIyWsHlrwCxOjMHVsAO0kXhM8ZKNpm8Fuc5S8YcRlV1
         nw3s+h8/0/ipg5BAhufq8yUNdAacmEMxPlxJDaZn3vxro99u1BlYcuoFk6C+TCt4gTdl
         hedsTYLlJ5HOr50meCQScgdrH+qP6zMKpwVflv4fCV1b9t1d1Bt5k/OYFCTk22dde5fK
         Poyk2tratZ3Sg4SaTs2lvDYkk9Jw+l4eBDOhseqxmKUp7rqajxAFicnhrnUeeujduEpi
         vYJcWeMcw1i2oYlpu1CGsm+h2HgK+8R81FYvjesEPitDuecj8QBKWsTF7E6ukIlXVNi4
         GrOw==
X-Forwarded-Encrypted: i=1; AKwUvBz3TmrEdBgSXt5TfuGgBEClNx+405InkPJaBWQM2RT3RxNJ9bu2e2nw2UBdnN8eByQRtZY=@vger.kernel.org
X-Gm-Message-State: AFuF++nkEttZlb8hm3eGZUNHGNN0W59CmJTRCPbflsSfV6KywdC8ITnN
	HMWIeKBp+DN/XaF1Scmajl4NU9oGB0nPqelo3cNltCLyX/8+fR9sVUJZhAwirNbVrnYWjDCVhQk
	uaCx7fiAiRBdytuBsx/+UFVURykPIMSRMMYnwX3eO
X-Gm-Gg: AYBFou3kNeP+8ZTDvUUntrWd7BMo58OkcZ2enAJJTAg2wK0mpk18IxWJePU2MlLghOG
	c/wWfTPvy8UoB6MPvktC4WwrMBYSFlfUe9PleWz41QgxzqZYiOnULV2bOxXxd2zM9fGZ1a6mfR0
	yj4Y52VOVoqTnnMGH2W8oCXR3U2bquI/xuJZ+GZlOO4hbsP2SQKRdBBweOdMYSWUUbaISduW73N
	CJCNKcAuW0Ve6lj6PLr95kh1mNrQq/hndSbzoR2yLvIukw+dW83nJqOz3bMKyS3YY5S1AKNHhl8
	8mck9Leb0UW19eYml2YKbTCbu9z0A/La3yZBYBeocc7MJmWZYwg0TPSRj+bLTEDnFB1O/52uj3n
	dgvNnBltIY/Jcdyy4Y//HQlo=
X-Received: by 2002:a05:622a:6110:b0:532:a17b:9581 with SMTP id
 d75a77b69052e-533845a628cmr6735861cf.3.1790837396410; Wed, 30 Sep 2026
 23:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
In-Reply-To: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 30 Sep 2026 23:49:45 -0700
X-Gm-Features: AclHuK9dhHQKCtFtugTdvUfdTMSI4UfZzBSmgWLYPu5iC0NMzKBfnF-OSJYnBWY
Message-ID: <CAGtprH8NqkyCUohpmeP_T_M+ejD7a3Pw6pwTYg35Y4EDC-r-tQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	pbonzini@redhat.com, kas@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:52=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
> Add a tdx_hkid_alloc() helper that charges the misc cgroup before
> allocating an HKID, and unwind the charge if HKID allocation fails.
>
> __tdx_td_init() currently allocates an HKID before charging the misc
> cgroup. If the charge fails, the error path calls tdx_hkid_free(), which
> uncharges a resource that was never successfully charged. This can make
> the misc-cgroup usage negative.
>
> Charge the cgroup before allocating the HKID.  Wrapping both steps in
> tdx_hkid_alloc() makes it the exact counterpart of tdx_hkid_free(), i.e.
> keeps resource allocation and release symmetric, and lets __tdx_td_init()
> simply bail on failure instead of open coding the unwind.
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260710040153.D8EA71F000E9@smtp.kern=
el.org
> Closes: https://lore.kernel.org/all/20260718020348.3B4221F000E9@smtp.kern=
el.org
> Fixes: 7c035bea9407 ("KVM: TDX: Register TDX host key IDs to cgroup misc =
controller")
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
