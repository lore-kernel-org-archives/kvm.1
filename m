Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3354B95BC
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583028; cv=pass; b=gW/9LM/oZvF5JI90nLGkMGgeQIRZlegHYE3okTIj30W7fy4U3u9DUbwssZtvY2X2vi2dPam0CgMrYrmCHjetNdF3QLUP46eoFQzWxZwXCxod/xhDjKQDbBLO87pMQUQ2q24ODLs7HF1uIjB64XvJ1odx+++eCUxFH9IcjkaXhEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583028; c=relaxed/simple;
	bh=K1VkZN9Ax/ivqRQhY6l3VgzDLSp6+7t77YixSnLTILA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hO9Jz0GFX4PyxK+ewK/6+YeybdtULPXZ1pcLPaut7MKxQCxQsoVhx4aK0mRYspi/KjSAZ3xjRKuu4rDxu65v5bWJo9fBcQXD2/UUH2qgQELwKwo6AvOeOZJ4s1SFpjNe1tsAqT18OCywbQzkIiFxzXNzqEZLqcDO6XDppk0325o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOWvHVmH; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOWvHVmH"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1b845so1241506e87.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 11:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583011; cv=none;
        d=google.com; s=arc-20260327;
        b=rc1dr+4e0fDGma6AfY+ULl1uJuC1Rl6gQpneNtTWHw1QJElIy+VbHW2L9YTkNXAUkT
         LC1uGNJDWLibtRSXmJjMiCEU7YCJIPNu2Y5aiP40R9emE5lDV/IR6TnwQLGb02AyEe7M
         gI27tSAaelc7CU2t60VQbRkGmZD8jdeK31edeDtlf7rOeMUFAY14DkqhrKGG7uc1lQ/k
         PPHuetGgtHzlI0blPHk35ia6Qjl6FUePL5tIKJE7+Q486GvsxI6VCacEdzbMV5SFWD1y
         15EOJGEY3AOTlbzOE7KfCE1yOSvm5epGfBPyPZ5RRZVIf5+XV/TjQzuSF3Cupp/y3PJN
         osAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iA6WOY7U5Hpnzgqa3cIbAuP1d1sT3cNwxEh5sU4xF5Y=;
        fh=kbBd0KhVOqRJYNEu5Z9zuMmro7ujZvLg2Zx6vAqOwmA=;
        b=HOk84001bGuCQSVgHpzzTimS7tL6B4YhKK/qvba7x3Gpjqrm4tVlB2P2jqZGYrCPbQ
         o37/4nz+B6U8eZE72KE9ZTSupgJGM91d1AxtZ3NnvsaW78EgT5GZjolrbncRDXI0wIua
         QAvq+Bc3sL3k+WYLVzdePYzNf94YaPj7NhoSqi80musvDQFXZ6Cgs8ty5n4OqUVtDGei
         4f3tnGvo8mfsomkDI8E5SSqAkmH2qiuHOAOMvHKEnjCgYeeQcjJP8bmAOXKdfI4iAMDp
         AftLNLVs0h6FXPkYEmo9dytsmRSE17GZOOIYuD8NMB8Yvbtr6bMchM5AU7kP+xhKsRvq
         n3qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789583011; x=1790187811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iA6WOY7U5Hpnzgqa3cIbAuP1d1sT3cNwxEh5sU4xF5Y=;
        b=TOWvHVmHt+weCIsIpXWwEjsqy28ZKumadJvtsv3OcYPUJwCRtgl8HskPfEXVpHE4L4
         FuaN1he+VTngVx0oarqnwK1kXYWtY5WlmjIzQE6gzNhbzrJ8/ETfqSz3uJunzJ062g2B
         s8CIU6mX161xEoWXmqdyx0/uytT9WN+XBImm76C+JZTtlWBCdu279L8HxEL9Dz32nfcb
         jRm7pPRpw4VGbMqiu5K4WmLlQcrhHDZ28tC7fNMsDjo8pVSMX1kkMK8T9U9ClyoDdV4k
         RcV48HfXU9I4ELPqR1UyyWGCpEReoR7jDPYkD+BzELs5B9vIDP3bERTLyjjOk227sLYL
         JJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583011; x=1790187811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iA6WOY7U5Hpnzgqa3cIbAuP1d1sT3cNwxEh5sU4xF5Y=;
        b=pZ6Og0Urv7trMOEqRC8UHDWfeSq6bO006CATgM75I832v/PKI5Vr1MugsacxYAUQSP
         EmikRCfilTI4DhDjpSW4oXCa4K5aQhcB5VfwDEGLIrQiSDcMZLdwzSPSY1QX+Qsnv0zM
         zXwaBHKqJ07nT5w1FbmIXGCAgnKkKodYdlWL0ANZQwksmb/2kzV7rrsaPFxc54n7QSP6
         /b/AXminnuJPJmmAYJc48/9XKZr7vSFEG5Li5aFYcPST1ni2Npr8QXpECNy4HQvtiL7a
         6EDxF9ApcCNAVH92uqm3jXV3WTj+u7Bu39kUGbhzvoNDBIxqUicfpeQYYNjUb85YOOf1
         KwaQ==
X-Gm-Message-State: AFuF++nSZNSWeDLUCT1hfhw1+qydrQpvZg3PQIDqynMD8bTEbHrLDLYA
	uFZVdXlF6douybpPy9Sy3pQH8e9Sd19jzP8UKjriDEEJG9snRi1vVJzgf6yIQVFIMDDqbbTJFmR
	72hxYvFuxfo6myX2UGAsgc3ysJseR3SMsM+ja7DG2UWluvKuaty3fCcFiASNvrw==
X-Gm-Gg: AYBFou1FcV4v/IIQZCO9ta6MBubIzPl91AnuWwTbfu7u6O8aZS2YNJva6ljYQXlMwZ/
	M/m8xGxKZ9GvlZGHOfDMCcHP7m0oox1D+8VUh7SrmzK23vIk7ITUCzPIoLRMsDBy3pw8XVlSdYe
	UqbtQgc4RDSRh0mCFJgzhS/2Ma3qcbu7AyqxAlgyxaGeksIsNu8WimgVHW2sK+t+GfiWyynfZBw
	BcPHNmBjgLVJ3A/m9BpfZxeMT94aY7L7eUFJBbzprpcGYSiuuNIZ6WKlVc+e4N7C/BnGKgdC7ns
	O4NxMDmbRPgnMCXlRCocP7sqIB3gos+kE7nqLm1lSnRXB61xyW2A8A==
X-Received: by 2002:a05:6512:1293:b0:5b6:1a7c:aa13 with SMTP id
 2adb3069b0e04-5b8b6640be1mr1009695e87.43.1789583011057; Wed, 16 Sep 2026
 11:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912083611.2513845-1-suzuki.poulose@arm.com> <20260912083611.2513845-7-suzuki.poulose@arm.com>
In-Reply-To: <20260912083611.2513845-7-suzuki.poulose@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Wed, 16 Sep 2026 11:23:19 -0700
X-Gm-Features: AcwNN1Xa9rZlSKbZ1HJXqNvz676wwtG0Dzc3HxbzhCyZpg8GXZHTQsxrOGLMh6o
Message-ID: <CABpDEum16ZzLSjd7Yg2Ge6VjwL8S8xxtSs_AsqOeNT9-9FNKKQ@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] firmware: arm_rmm: Ensure the RMM has GPT entries
 for memory
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, 
	sdonthineni@nvidia.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:37=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
[...]
> +static int rmi_init_metadata(void)
> +{
> +       phys_addr_t start, end;
> +       struct memblock_region *r;
> +
> +       for_each_mem_region(r) {
> +               int ret;
> +
> +               /* Firmware-reserved NOMAP regions are not usable system =
RAM */
> +               if (memblock_is_nomap(r))
> +                       continue;
> +
> +               start =3D memblock_region_memory_base_pfn(r) << PAGE_SHIF=
T;
> +               end =3D memblock_region_memory_end_pfn(r) << PAGE_SHIFT;
> +
> +               ret =3D rmi_prepare_memory(start, end);
> +               if (ret)
> +                       return ret;
> +       }

Hi Suzuki,

What happens if a system has memory regions in memblock that are not
tracked by RMM (e.g. CXL memory)?

Currently, rmi_verify_memory_tracking() returns -ENODEV for untracked
regions, causing rmi_init_metadata() to abort and disable CCA
system-wide.

Shouldn't rmi_init_metadata() skip untracked regions (continue) with a
warning/info log instead of aborting? That would allow Realm support
for conventional DRAM while leaving untracked memory for the host.

Thanks,
Alper
