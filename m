Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792646970;
	b=1EOuovvgmw9XBsrjCQZU2DeR/rfGA3cj7NQElCmGTa7R/xrL/y0v7QZ/TJi9EdLEH6BM
	 jbR/CeCxEYf1ebPojYH9AwDldWuHJYJuA6U7Qlh4jVcCNNPJ8Peu2qsvl2zCLqentv9yr
	 CrFgmiPjZs8dm0e1NrtTeZsU8pG4uFLAfvWU1fUDHGzF4T57Un22sKhhihN6iJ9PqCip5
	 FITF2Hq4G4tFiGO4eU47EtdVXqcVNauDeHV6pDkr82QvjFIXg6Uqn9eVFU1C5LxZc7hYo
	 VQrQGczQwI259U5JGGn4hWLx8ZfgGJBb6CL+Splf9Doruf6K3VbvoR+Ty2ZeyPGcpXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x8nc4lFKIflj0031U24QKhHWYfSWWl9JsVlW+Zb/WiE=;
	b=GTUbcy3xMZF/wFC46EKWS/aWYff8kNYY9SgY4c695cUSOcq9wBThbZOkaOc9QaXliiul
	 bbGhqUiAoZlAkPt24pwmubO0sTQ1G6pqmuVjYXaKG1hwUCB0PTVv/ZIF+z9Kt3oqiAmU6
	 7ySEhAIWiTXjDSZci38X8QgEF6n9G9VB73y13OIekWH4V17964Kt3lPktK6dlJ+lTjdki
	 E60Slk2ZzHaXs+MP5agTMDAie+KZiqU5SczXN3ZUQmOFiR68AtI8msN8S7vxZOaDycT6x
	 jY0jFjXwSJ5fVAcCvpmLiLm93xtx7l65QJPhi/g5v3c0+TOw5nKQcnPaHcrCuQxUFhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMifBLZB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AQ4yC2s1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9D606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D9D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMifBLZB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AQ4yC2s1
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3j0UX3094448
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x8nc4lFKIflj0031U24QKhHWYfSWWl9JsVlW+Zb/WiE=; b=NMifBLZBvyNscsIS
	OlUvMCfKkwPCFkBrMlfc7wd2xwjWS83v9cCeScE1nB6BCWn5HCDwe/Tiw8VDEg4d
	+3sqA44Bv5Hy6mnTkOeUqHsMdcfDTWCBgaxzOzveOc1lqCsE3Ea/7YsLgmTzf46M
	z4ryNy9OOwLujW6rFsRP4E5zITTRbakLd1U6cPhRO14HAk/F/nP+goKmIhTfwXZL
	CNpUHfBbQfJYO0RgUCm8iXkBc5jDVCqftFHYhYgHc3VPVC2wMLNhl2jUK4eM7Anv
	y4pEupXJmpgtUeE+3RG9vHFZs7cMiLTtcevvnw0CXLLIi1SlCGltQREdCvY5UzcZ
	csveKw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bgssn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:29:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c5aef2a74so3410712eec.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 22:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792646968; cv=none;
        d=google.com; s=arc-20260327;
        b=lhatREk3Vme+2tLEF/PckCsS7RO1M0RFtRqk6p58jmAGy5OYsDkdO2EbFTpBsrLrIB
         kG2PuaYTvGkZqvnVBNdXKyTwog8ns27CHiPqxo5gA6G2NhWJ6VE/0UblDj+q6E0Lej6j
         YGwMMD/76+nB+dS+sFftQsS3IoBe/1SH6NDAmWGJbAW0Ah0OkJqY4iRlqglvLmCysT5A
         NlTMoOmKKIDRmLDLi+lfqw+ehli6Nvar4xVTZp5/djFCVcEj4w3oqNKgizeIkUfxRlCh
         Z22m8V12dDlkkuKIPg9u4FbV3sVDM8CcfWwgGba6rsHat6MKGJNQbWQX/YaO7CA9rLc4
         hFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8nc4lFKIflj0031U24QKhHWYfSWWl9JsVlW+Zb/WiE=;
        fh=s9Hc77Bks8eclH+qYnfAlNvh7HnCBEV7ekA8DoH6gk8=;
        b=tDW3hWBAQngIpx16il4AuN4uk5d89DQrzsxXgWGbvsIhfg0c1k6ood/NI58iA3Jbrx
         XpCLJVtZFJ39H2dx24ZZhOezQJe8GWXrTI1R89lV3DEVAzRD0vsTDEavHWBAABwpOq5/
         u+FJtN1j3cYwJPJ61HvQNhyizPCYT+qvmwUK+mMDFval77NZLo3gOQ8EcvDFAozhyMUj
         mQaYsRcUhsP6ZtX8pLuqv7Es2zMDCPuwySLk6EeEoGluStSGqlZ/d2Iq/ktcEWwZTrdW
         ah3PibVHW2kBIq9r+mskfWn3syqJahOlIV7JBAHoSB0Ngo4uGewYFdZ1lt8WoYrhuZHn
         boJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792646968; x=1793251768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x8nc4lFKIflj0031U24QKhHWYfSWWl9JsVlW+Zb/WiE=;
        b=AQ4yC2s108bfpJrkMbPBnfeCuWrSvhwcQTgQd109va9mEopX3uSN4SoQkAAxyHAgOY
         Xrcdehus0Br/84fvcZiwQjqf7ON1qm4PoXD7mF8LLZTXFPsNugratu0Urmme+fYX4+8i
         1fSCx1EG2KIW93W97FSvHtMNr8Wra4xl8I9M6CN66u0PM9cRxLaAngQoFkFbqw0mZhci
         7Mg3fyyt3/MhERsgRGFnvBzAKfA82d7s/iLBJDNlikfcW8eUQIw1teSEHttLy1YVHtJp
         SQif1cSAJOiz8BaHfohAy8+yb43FibaPY/F2EjOFuXhgM8ZeKUgRNQROT5EmwROVqkK7
         RNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646968; x=1793251768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8nc4lFKIflj0031U24QKhHWYfSWWl9JsVlW+Zb/WiE=;
        b=S3u/148Qzh2LvIoPR+GAvP0IHW3xRqufOhuGsInsKtAJmZacdLLhsclb0rMALh0BYO
         vTyRXVZ0Qgz8p2aRZXPxEBDxv98fvly89bJib67DDsLzcwMULHDC/3D7sDQN7qHn8z4c
         9x/ex8w2REMH7aUwfg4QBQU96LGNFIKGB0kAmI/F4E41tgLk3ti47aCC94pY4KOqg0Wu
         GHcY/PY78iS5Mukres9NAIpZFZJfuNrFk1obf2KXZeLn0CaYy0mhVrHc9W6aipQ6ww+2
         Yh8yEruzIv8FMnK6H/KaNtwgvErVLGprMZ3Qt/vV9IuBscAIb+sTbP2oW3bygFkJY41J
         UGmg==
X-Forwarded-Encrypted: i=1; AKwUvBxCf7OYEm/ZKlfZlTcnOncfrqtDKjWJsDb6wfjglIIDsna6GYdxr1DF9L7tlhK/FhT2MFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgd/B/ZVqnzefMZJdJ4FQkAwjpf147BJIsgfBXqSNknCcQLtsG
	t7s2vtDm9FQsT+z8zaQbuLfkWbgkGl0k7d1/hh7uTgq88s8nBNE1J96Z4zFXQA8KVc1v0cmdiMo
	S049WoNjhODippMyh3L2xkTHGgEzi/u49IDU1rAGIam0GWgdpy08l0kQjJd5/SnU3HqpTbzF8tN
	+BCKGTmh8kP9a49x0XvD4OZy21x92bSg==
X-Gm-Gg: AYBFou1+g8CrdysJ0K2hdB1T2wTHTD2AcNPxvBmXBvLtE/9KcAqMbZvgBrlVuuKtD/N
	D/DS4UQA5s9Pn29drT6zW9+AsqQFSpJ9AVdL8FauTrmbelpU/nEhqRvPU3ttT8WyX0QyDvBCOjV
	MZvMDyExrpbZuV1Q1mk3o8CcMHtyycL/YiGYwRP6eb+FrcjfnLmZmIOFTc1fs=
X-Received: by 2002:a05:7301:7a08:b0:368:a679:7fcf with SMTP id 5a478bee46e88-368a679852cmr1863351eec.25.1792646967842;
        Wed, 21 Oct 2026 22:29:27 -0700 (PDT)
X-Received: by 2002:a05:7301:7a08:b0:368:a679:7fcf with SMTP id
 5a478bee46e88-368a679852cmr1863324eec.25.1792646967328; Wed, 21 Oct 2026
 22:29:27 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001-b4-mmio_load_protect_x0-v1-1-90515d86f201@butz.st>
In-Reply-To: <20261001-b4-mmio_load_protect_x0-v1-1-90515d86f201@butz.st>
From: Anup Patel <anup.patel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:59:15 +0530
X-Gm-Features: AclHuK_iYzosfJ5Dr7--r4SAxXJKbvTYWI4tQYeVRKuVqR1ywsT80cvntNZ8DOA
Message-ID: <CABBgwmtE4ZX+wAs9aRTeUDGkWtyfgpF_Ou-Kb5UoFXE88zdkog@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Don't write MMIO load result to x0
To: Stefan Butz <mail@butz.st>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
        Yifei Jiang <jiangyifei@huawei.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAyMSBTYWx0ZWRfX7F5O1sWw+Emn
 cR7BbIZLtZC5xqLfg7qvsuARYISMqSzdoGVRb7foRuRw4ZH8W2lXcqcFgez3krHkbV3GB1jrIu0
 LSna6gFiQ+Y0KofuT1lxj6+6IFhu11dNNXIDELHlidPRQsPp5xkcg31pGV+KsFQSRnz2G93Gce1
 sTS8iz60A4ig49sZEVX7eaT55UOqEcUhlYU1WifxC0QbDhK5xQcaCNPZEJlsK7G/DHIylzv7OQ1
 /gEmAoGEsXYaj7suDEPllSBiSREv8SaT+DY7w46YxoShDHgqvmTgbhEcDgubxAuZuS5NGv9dJNX
 SgU+d2zF7u/8oh4YN1GatV9pR4dQRHTGqdyDOzds8ya+BgQnRr897KY21T7ervOMQAcYde+BZkt
 YMAL5nWUP4TOZiQ0gSS2Vfj2eMSpvc1e9dyRlzS6YEpfeIAuG0kOJqI82WYbSoPB9BCxyrF5ypk
 HR+1i8jDYQs704jbgyQ==
X-Proofpoint-GUID: weExQwX70udS1Anw98x5QyH-X5vHx9R5
X-Proofpoint-ORIG-GUID: weExQwX70udS1Anw98x5QyH-X5vHx9R5
X-Authority-Analysis: v=2.4 cv=CMy/zhrD c=1 sm=1 tr=0 ts=6ad99f38 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=W-_n0kkjAAAA:8 a=OiFHV6dps91ajMyZhnoA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAyMSBTYWx0ZWRfX6YCqYmQxSQ5Q
 fL82liXFxB0J3GvnCdgwqDdl/iWfD8X35PV5uQB2VW4aLq3Y856sEUs64z+1ocSfMyYO83Kz1K4
 mjtx+R2ZDWtE7yLEJCa84teF4S2n2RQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220021

On Thu, Oct 1, 2026 at 1:05=E2=80=AFPM Stefan Butz <mail@butz.st> wrote:
>
> An MMIO load with rd=3Dx0 writes the result into guest_context.zero,
> which is never cleared, so later emulated reads of x0 return garbage.
>
> Fixes: 9f7013265112 ("RISC-V: KVM: Handle MMIO exits for VCPU")
>
> Signed-off-by: Stefan Butz <mail@butz.st>
> ---
> An MMIO load with rd=3Dx0 writes the result into guest_context.zero,
> which is never cleared, so later emulated reads of x0 return garbage.

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index adbbb59a0f36..2a8dc2b88ba8 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -647,7 +647,7 @@ int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu,=
 struct kvm_run *run)
>         vcpu->arch.mmio_decode.return_handled =3D 1;
>         insn =3D vcpu->arch.mmio_decode.insn;
>
> -       if (run->mmio.is_write)
> +       if (run->mmio.is_write || !((insn >> SH_RD) & MASK_RX))
>                 goto done;
>
>         len =3D vcpu->arch.mmio_decode.len;
>
> ---
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> change-id: 20261001-b4-mmio_load_protect_x0-5f5fc11ea52a
>
> Best regards,
> --
> Stefan Butz <mail@butz.st>
>
>
