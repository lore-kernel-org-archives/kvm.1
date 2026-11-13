Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570444;
	b=JbssL+dx7m5GaBAaMbkLpaQTsXjKvij21HKMjOo69m+0QccB5Af4bZQDIXD2TF/CvAgB
	 oE0i1nXVbbq9xqc72/RQOpGnhmYOfxrnuRGDmTRgPL/bkowRvikaLkdWcd+QiFASPuzI3
	 /mmYIgfMjjRS4IaEpWePI482xQw7I96aKu10Ff51r4QE3lYlrr9pJ9prGZRvJfSBMkheb
	 dWjhOSR5UwVDwbpYB3Bfn+0h20tJMiXFLeeE6kSElGf4H5bJaTfSQ6pZIRZyRjtm3pIaD
	 v6ylmPaGULeb12NFCZbWqlQxME7K6LRFW1MYdI6WXDzbhcKcATLtOXy3oHPAXafrf2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1bKaGn+sVsulirD+PpfXt80s+OYQQHNZq3eHTFDXAqY=;
	b=tpVoJ2XWNrGn4d2rI9HlZikpPkwLfAmvYUgl4k1aR7zAv3GOT3jzGtSXrkXxnvLx6Diw
	 ooiRR/FakL63NaT50uNdHmfTyCdSS6O/Y8aLXMT5feomYj6cVdV+lTPC7ExSeKJpwSWVo
	 Md3L3SEhtbdofZDhWB769J6rFQ2sVduKSGb+OvelijMhj6d9H+k4Zg+s4229WYEUQ0hpI
	 IbLCuQYYskgB5iNQdM178kW29xmSr2pqB+ixAbkgAY4xFaPVbSJFZPavuXCWhv8NUfTDN
	 o+yFmVHODq5CkleOYCUVf9CJse0ZifcddymvZBW/E+50f1zMTUpL0eBZtjp1Y1qmYKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=UUoakxNy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F2606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 015F2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=UUoakxNy
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so986855f8f.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 03:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570442; cv=none;
        d=google.com; s=arc-20260327;
        b=mmXD9LWpRNSAoYpF9gMKoEqrtReqASsyje5lQIAidnCgtgDp/aLo/U4tOrCEwlZkh8
         8s0MRH+RAmZtwXRnMkygdF5Hiz/tet+mbM5BOngg7DG7lQyvwIp0zLtCuA3RdeNulTzm
         nD/OP3XbxYlaq1xMcnEsZJ7y06v4AIUzng8tySz9QeMnU8sdoXzhUiKa7M0WYPy79lfH
         qGmkx09HrZGbAX9kNsGwvxU7ko0pIlip5mNAYEN5oIXfOxXhj3iuMkxGjQOiINnPwF9l
         ZPvF5xTfmnrKUp/Oj1/DvKip854cqYHGAS20ZBT7Inq6dVz7hAUwFMT4ei9FI6RBKPDR
         ExOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bKaGn+sVsulirD+PpfXt80s+OYQQHNZq3eHTFDXAqY=;
        fh=3/Mc+fsGRvvP2zd1CYUKfwvqipMs9+j8Kr90euBRPwI=;
        b=sbsFQGKBNaulOEAFeyAnpPgEmMBGHsp9lNlXVY1CMlo4MhwFmZLKu52tXWZYLUICBr
         XdYi5izCOCgG3D/Iu36Qm7mh7OhBVFxlNG5gJ1QGBgJKJMAt34bc8FFFjlcT0WkQVtlu
         lzZMNB3WIcQvHciOc9y+TWbhU4cHcSKOQ30XRkmWyHizwqK1w1oatCPvuWsxnfcjrsdS
         bu5CeOim6L1U44evaehnjq/gfhciX7kt40OfnmcqnAXtszGPYyI6kNN8x7A56k0mFuNg
         3tA8N2Vev2iRTAtca9vFFdPmyRPqtjG2v5X3XiqtUE/gd85/l9hsntQ9QQM5WAcLfXfT
         Paxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794570442; x=1795175242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bKaGn+sVsulirD+PpfXt80s+OYQQHNZq3eHTFDXAqY=;
        b=UUoakxNygbqaRMmeXi27vUG8S6ASnwGACxEHJzp5RIE3shYglUr3INivptTO7Becxs
         CWfKO6IuWe3SNiRUJpzfSrWM4+l2mO8MN/BbYOy0wKc+VvTk2chdnNkRuSaqwNRahNIa
         Epb0wPZgUDyevHTI+0DzZaTq6BucTXc8Rbx4YHZwafxVFdNuTGsvr7FIUTka9B/lpXSZ
         jjiYTttS7M+ArEAMAj4RfpgOMYl85NdHAys5QAayyX7gqIQbx2fGrrXA4q+/g6ACo+av
         e+kFvFB+aVlLeN01jHoS/kDu4b9AZ53dXLbLj2zSUA/eV5aHzI/F85y8kyrECXd89EBe
         c3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570442; x=1795175242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bKaGn+sVsulirD+PpfXt80s+OYQQHNZq3eHTFDXAqY=;
        b=ddO0t83S1PX//nwcAqhSXT0kDEkmDQPNT+fNRD/OCBPaTQNMusY2Pa6741uPLhbJsR
         WweDjFDFTC5ZvqFrEGDeklGC44kouluI4WxFiQyMLfdBoRjO+EWwG+l5fwX7Q8QlzJzq
         nReyoqPGH2vrXiviKqStTo1ZDUtj4ys15VYqIwgZj9vlIAUpC//huW0BgUo6aVtxU3AH
         qG9wFpVQSWOBrJjx9bY2EAymTaVNOdjZC0IPO5hWf4EHaNo5m9urhPYVWazIWVRW51My
         Z+dsZOdSHPvRv6Jhl+Ty0i2+t97UyOPpxuKEuUpo1O1i+wO7hDkBVARQmPOdvtCWvbRY
         427w==
X-Forwarded-Encrypted: i=1; AL+hErGBIj5moEIFkQECttgK5j9OX7LJ/h+fzQ3NtgKDXWP+o/oZGkQAn3LQ/X1ITb4AQfQ6fm8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s1SwE43ZmUYWsnqVLi9/6tk2QQ0jrO5PzH5Bbwt9f7NW5xlAg
	4lVrZ8v05TYAf2KpGrsefJbjgvsfaY/Hy7N5V9NVrNJPSOOkz3JOjDlt2mvopLuTvNKgzXkyskO
	p6lY2/7MDb9QfeWwpVOK9HAC5qWDMG9qE6MhIbVvK/g==
X-Gm-Gg: AYBFou1CaLvrxSe0v019Tj3Zw2Gd76oSV2KdKEFmxWfXtuIorJeAwtfgXolVXPLEhGs
	nZ/aNqgwCqCfo1jxEXuAY3P1HFLAUIAKcI7kKb5QMDNhNFKqBfxwJ7pORvAnTuUvz7zlPomUMWo
	0x3e59uqvE2S6dmFqFjSWn27DFt+e26cFaw+b2sT1Jo+9bgVZpxnJ3cm1G56B9kFilF1jLKMByx
	k3WiaCo3qGqzJOeJoFQhm+pAGvYRj0HYwWkt4FCYqqm8HqoqIqYcfPUgN7itV+RYBTokzTl+7x7
	3H5twnSobl86FFECb9V2wbv3GXAUgNmpnlzuzFxzzMAkDxrxlhSOMES5J7eI481ro4LuwmuDuI+
	51Ktcc78YvCeiAxFp/pJ28t7mw9Lws0q9PXbYYHz8tWKdWPW5TxKNu6WQG5Bo1s3xPBgR460BxO
	m7ZviMFSyGaUODpcIlDouSw0TddLXv4ybsGgefTDlIu4pB/ia4mQ2N998=
X-Received: by 2002:a05:6000:2006:b0:490:6e0f:a024 with SMTP id
 ffacd0b85a97d-49c70b051bbmr5548639f8f.13.1794570442359; Fri, 13 Nov 2026
 03:47:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027062602.323691-1-qingwei.hu@bytedance.com>
In-Reply-To: <20261027062602.323691-1-qingwei.hu@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:17:10 +0530
X-Gm-Features: AclHuK9uFGSNKoGCuQtKwYDOZuyVTnpTYaV59-nL9mz1TmdnUXZYOT-rcssss70
Message-ID: <CAAhSdy0bSJQ8mhWDu+zYW8dWowtcV-mDGHKyp4LSmvnbLWEimw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Validate PMU counter info using available counters
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:56=E2=80=AFAM Qingwei Hu <qingwei.hu@bytedance.c=
om> wrote:
>
> COUNTER_GET_INFO validates the counter index using the pmc[] storage
> capacity rather than the number of counters advertised by NUM_COUNTERS.
> When fewer counters are available, a guest can query an index outside
> the advertised range and receive success.
>
> Validate the index using kvm_pmu_num_counters(), matching the counter
> initialization and read paths.
>
> Fixes: 8f0153ecd3bf ("RISC-V: KVM: Add skeleton support for perf")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e095d1ff439f..ea788619091a 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -560,7 +560,7 @@ int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu=
, unsigned long cidx,
>  {
>         struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
>
> -       if (cidx >=3D RISCV_KVM_MAX_COUNTERS || cidx =3D=3D 1) {
> +       if (cidx >=3D kvm_pmu_num_counters(kvpmu) || cidx =3D=3D 1) {
>                 retdata->err_val =3D SBI_ERR_INVALID_PARAM;
>                 return 0;
>         }
> --
> 2.39.5
>
