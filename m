Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91035F619
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250718; cv=pass; b=utSVZIFSZ3DpvoV2ILBRglvJHPYzB4H+GqAckxfLVBm5fspPDJQhLboSv0AsEzSfsIyuPLggbgr9SfSqqRKom7bJK94q2ae28w+x4q0SdNHxTkGYX7lKrwMZWhv1yOhqJQLp4HgGFMu96Ve2yxX7yeDhgNxZ6KcpI6l4Mw85u/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250718; c=relaxed/simple;
	bh=Jm8AzdPrPR6BhXQyJz2nZ42hfc8fkKPUPVq/AoDXHaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4rGHywkStUcv5v/gAGDSjjzAU8DtvOZQc5bCdMJ9FNCqX85zo5dJZYhi9CXa0ZioeDPeW34BEmouSrHyDNhHbQBVIRlL67k02KQc0+Zte9sTly5VGy3K3tlAA+UG1SsOXG7vSAVJlGAKez7HATjvtkw5APnLznX/Qo9vRgOjjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5YGnyIS; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5YGnyIS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f259cdc86so84324185a.3
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 08:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792250716; cv=none;
        d=google.com; s=arc-20260327;
        b=ASEgxRjoR+vbSVltErT+HHcnio09CPoVj5DOfcH8Sr+JrImEZcwp+69+w+VwRiUU5P
         yAFh/j+Pg35+9+A3jo7Ec0Q0YBMY6AWWhGaoo6AHRGJrgnRiqYafJEfQ9oOFPr7SF1jW
         9YGxS69oL5Tr0Hqo2YIfZ4tzKre6yYq3HTlGvv0PAsARJgCAPK2EDHUF5ai8uGgxqoJp
         RomEGcuoRFStLOgeZ1UHdSybYkOvH3hd5OTFBXQZ+gq7pW2CX1YSAnBgN41/iuezvmB4
         RU2aLX46gbWl3fruloTAU1mEcQ70SaaUE3eGI5w99/vHiLRuNZ6qop4gyu8m0WVdZ85N
         peug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cBiNZFwCvoEsAVFQ+85lVVDF8nZW55yFDyjuRN5OJEE=;
        fh=1BUbqdW2VZNpSkIQD7uJC2aN9uYU62qgu0C0L1AQG3w=;
        b=kRJnrZIEHXwUjnUDTxIAS58fNnuMa+oYsws/QpwX7QjnxxrEVuyjVlhjWFwkwt5fAH
         cYVFJ6dp1UtuAbRDYpCbiOxPcnaOOEUobwcEswz4YN7IlOHzgmC3L5ekCo8i3kW5/+sR
         RnGz3jgcre1FJu87AkVbT0nFQdDhKf5+q2ApQIKEfWW62bQuRK33h7lau3TiJF+H735M
         ZGHLPPgD6DTHLU4unUuXGtYXMTrBGKMwpdwxOYyuH/cdip5b+FQB6nm9wlR0IWGRDV8e
         hJ5EkWZj66ulppt44fo2MjMCf80bPyXAdV9pf2mRmvz5K5rTOMKi7tfTGttjJYV9sRTv
         qWvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792250716; x=1792855516; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBiNZFwCvoEsAVFQ+85lVVDF8nZW55yFDyjuRN5OJEE=;
        b=S5YGnyISdiqMD500TqKu/2332EmWoUTKP87+MUGOG6QPTvSlWnUVne+RBQtXXf8uii
         pTMUtqFbFW3D+D6pM3k/cJkdQMEtMgwgDqSN+adWgX9u6IC9p1vl+8FJdIt5KhAs8bCN
         x8ZARz/HAcGgUbbL9M7rj+p976MuH5PXUFwTaRTVghbH5D2z5Hy2P/HWdLK++bkPyG3t
         nVmM9udXfE1pQM6YnsP4g7iXiKQDpWjZUdkJxzeO7yLTl6+Ewn57TdAVcWGRQ4RDUMSl
         1/Htohgd2qUaGYR+t00PfMkRUHG9ctUkayYT3SzEZoX1ovEHlx4vFj7OddqUvPpy5OjL
         9WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792250716; x=1792855516;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cBiNZFwCvoEsAVFQ+85lVVDF8nZW55yFDyjuRN5OJEE=;
        b=C/hQfNd8UEwdAz40SGS9r9mNiGgMM5dK1KIXRx8Kle9W6QmGcqIs22sCzJqw70cUc2
         QgBNPai4qifxfeyq736hP2EdImhOSjxH8Gtiitier3MwBCKAuL9O5u/La5HIJJmDUl8A
         mxzIuCBYEzbgDhnv9otVTJUtPFSFD/JuSI8GZCcOCFbuhtuwERHbHy3mhsBxL8CUacw6
         FxnrS9HYHGvvYSDIqmoczsSk6nOs9sIjI6XNxvazH9LkKQk5rt1mulYnDN6tRnDAq9Hh
         Td2OslXpSm1j/27Sj1XmqHeaioqA+VwUq8K4HmF3gXZA4tGCEhDWguO/Fo9ZQE5jNJpm
         4lqQ==
X-Forwarded-Encrypted: i=1; AKwUvByAH07OoGTAuO1+aQIpAlS4sxIgxfQkJurU9MKZikfQL4LiOQYc7Q4reLorDDQYA3wqp4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW0ZtLQiUbu5CwRUUy1sRD+2XmvKaGSDXQ8CH6zbPp2WV9CRiw
	poyj2PB6DvX0zo5j7sW/vd80E9DjSE1oElsf5/XLpMQ1PLwXpBer8vzarE7vedjmhBJPYUOKOOT
	9cuW+z1wD1ptu3354AwXwK7/Os/aY3q5/v9Ro
X-Gm-Gg: AYBFou1vq71b4k5n3Mlra222YnlCcQ0M/TgW9G6pEGQLlDAn94wXx5y5Pwd+BZsMRH/
	n+4XZ3nD8qixCn8ajwyon9En3UfPEJVqs6akJCMTcKel/+ra5UDeoo8BA+hQl1+7DA375x3ftul
	CnBm8QXlwiG//M7ousU9dJT+bTDKyQ9PcoUSKBME9Dd5EpuJLRYWP2op5sdvzs5GuVL1DRJVVSD
	SUPeaC4yjUf8uXpBoZuNFb2g0yY6qs/Vu77VeQbLheOU0Bs9K4xZ2VHus5t1lEyXyf4HvPHfwUG
	1SuVUepSL9jxWx474cTfe/A+1stXPpTeKcMa5Ras9tWCsqSwHowxOKXxirAN4a0TzdbdA+RrT/K
	ze9SLz1aqhKFGZOizgamZbY5APYPQhjczDAWLIJAR4YLSlA==
X-Received: by 2002:a05:620a:2783:b0:93e:d051:8f19 with SMTP id
 af79cd13be357-93f29ced575mr485953085a.40.1792250716444; Sat, 17 Oct 2026
 08:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017110213.46199-1-tharitt97@gmail.com> <20261017110213.46199-6-tharitt97@gmail.com>
In-Reply-To: <20261017110213.46199-6-tharitt97@gmail.com>
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Date: Sat, 17 Oct 2026 22:25:04 +0700
X-Gm-Features: AclHuK8Bu8EDo40zZmiyUcWdeJAzBkx4-shpMZtTbASYDmEugT246DxrXg3J2Ik
Message-ID: <CACak8wNa-dbNMGO=4U=JpTqSYWdk9MC+DWZS3WxRwuRRvC1T7g@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: selftests: Test protection of the ucall MMIO region
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl
Content-Type: text/plain; charset="UTF-8"

> +#define CLOBBERED_SLOT         TEST_MEM_SLOT_BASE
Upon self-review, this should have been hardcoded to 1 (to clobber the
reserved ucal mmio).

> +       ret = __vm_set_user_memory_region2(vm, CLOBBERED_SLOT, 0,
> +                                          vm->ucall_mmio_addr, slot_size, slot_mem, 0, 0);
> +       TEST_ASSERT(ret == -1 && errno == EEXIST,
> +                   "Expected the ucall GPA overlap to be rejected: ret=%d errno=%d",
> +                   ret, errno);
This should have been errno == EINVAL check to catch writing to the
exiting read-only slot.

The earlier test accidentally passed because it used a different slot
ID (=2, not reserved) and received EEXIST for overlapping the reserved
ucall GPA. It therefore tested GPA overlap rejection, not the intended
rejection of overwriting slot 1.

I will fix it in v2
