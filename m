Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505877;
	b=wzcoBrwwxs2PfFEHPT9GsqouYfu1cWI8cNStTWrlSckOVFu8wRUFL0iFKziYwRtN/CgQ
	 AcjEkNPXp4SwdtTBgCj7ZmdnfOju4sipmw+mwafIqpx4ohj2e8Gyoj9xFS06JyO+P75vo
	 nJN2Qp08d6Ugb/o0K0V4dZ00q9UeA1B7fZLTjuYi+HcnTZGhJzELYytecfCsatCjKYCHy
	 9Ovxu/gMWG6ERIaj7Ht5nB0QtwuZJX7rqIE6otxKz3uAW/fn20zAo5bXJ+o9neYeN1hLz
	 RebSFLYbmQ47fmHUryH07/G08k33ouIhES5YLeDjFVZK44OqHa/+cuFz6PygUPI5uNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505877;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
	b=1EOSY+LEwVRoEDFbKXGDOAA4JSUb/rNO8IjkPaSAGuevHkqOAcCOpVg4J3hXRqOPBj5O
	 W3jCk6Fl44SwKe3kbB5s1xyTtRjqyt6BQoraz8/2J8aRrWz8bveEMxWm6M8DV2uNSHCZn
	 Jgf+PfShbTU1cZwn3sIxwxRGVoqOaL3vHPB4JVVBnrW8kk1PABE+8+nlafXn0BSZXbzgs
	 p08EG12YhiTKDiueG9sXwzxcbm5C7nzIljwSiyvBIer2+NALu2aPnC4sNDvUDAAO5DuEz
	 wnURjr5aZ1R+Cdjxw617b5P/HKVOFgzbJSCJpvRCGDiyix19XtNC0IZB65a3xPrNLtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6D606A32E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A6D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k6F13225397
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=; b=jB2OhFnb5kcQJfBh
	9PooZCIYHGNUVjDcGwumXONQT2rphRiM+HKb+Z5rBcfoZ9URBb6HmUCKyU398p1z
	0DE3n1unAJCPGSKA9qHqDKxoWrwnFiNfWRaB4F0mZuQ+gIyw7qVkk0rFFWIT+hr0
	xlGvD+nbKD4m1GM6eRm0zn5N+zABS6NWAAQ4zM+xLUUTfkXPLcKrmGNQSuaj6NVk
	LSMFCUkYtOrVzKgsE9JjRJp/p/+NgBxqv/l5UGfpSyCfsEnsySH6HhHWtAFvnFTH
	QiJHfUK8nig+0y+RvbrdRu8nHxWlPz45JWmVSfVxj87VvZ9rM/3qatNGi8g/YvkN
	LVZ85g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f1sjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:37:55 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67be4f2f42eso7121950d50.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 23:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505875; cv=none;
        d=google.com; s=arc-20260327;
        b=JRpQh5MvObZcN1Gs73vfAl2EfzOhFOjGJZs/V986C6NGl9228c6IKiGPAoVeNbmZrJ
         efQed7V2yIMqcnigomLmGESgb8YxQczWiw6ZoK+O+6qxhVR6V7rEngciHYct5RLW+U7R
         7//BpjxvlSVrnUilIIJkuLnlbvJdnqy/nYHB7AXH/FDOvteDzMia1BBo4rPrPBjbfMAl
         IqDzLVTufLUK7qDahX2TBu7OXPqo42H4YjShpkQUlsC2zpZkROCATVQAOG6HS3D6ZAXd
         QRVp5xtp728ZOPsN97wdrrztLyQlbwii85vLc3AgRpwy/IOUccYvKCs9+kcjpVtsqVt+
         sCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        fh=mdo0ROPhAXL1tJsFmopQhv3ZxdIMMJaVrhohY/CV2bQ=;
        b=kr2dw41dFowyFJj1lFoiH1WbaoMeK1Tw5XTFJnqpuFlImYyVjjNvAv0yqESGwyMGwJ
         u5yLfJSpELwg7VeZXqM8umFlnxIA8HhapsDf2KUoZANqJ8DsSehYoYvfmusVv0mHU+s5
         k0DhCyVAzHXaXwAoZh8vPPkL4QOa5u/s9aFnOKaAMmgXMQfnlSjJkd9LmMDX15ahes8c
         HvRrHiULkFLixx8caTRhk+9lghTPEk7t420pffIyFF7kslWGOnNMWUbmXKpMr995T1Od
         +C1VfxOqORqxFmmou4lk4NdVDVyjpi7CzBqnPtUJV19LtJtHAbvX38RTpdoXQDDF42gR
         PuQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795505875; x=1796110675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=S1+Iax5UjwdrBfjmC61+6GR7Ef9vLvndZMhbV6RF5f5jjGfM0fKOFIGSb9cZxbE499
         ufQ0Iw9iW/MkroytuRNTzxKljpJElsFF8w9uRLGP7Avq+RZTb57Ul1XAJRZ5qQA1kqxg
         7jbG878tFdG6DzFw+/37L1jhd6FV1aCc7/cXrp+cfOfsQhmbgR+jpkWB2+0CyWhWN8/h
         yrF5TtN9QZy1tEKAfvOEpPuv5AnxPa6u6OCgoeLhGxjDwK43OfnV/PUQdhSEXPtDxnYS
         FFlkC6lp8vy68Kr1OCdhQERS5xVbG1XGyggIdSHRH/KZmZy1PSroQztV131DD4SIsduA
         xQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505875; x=1796110675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=tUbN/F1x94B64okJYJrbFSRDIt1anqxYZDgu9QA/79BhRmtzbj4bNMt+7k57sN0TVT
         OftnD9XiuB5LAekKtimyQdpTKankxZzc7T4MLxaHudF0HX8hk1uoFSdq030LfOK4Faiv
         lonniOI5WbvLDdL4KbZd53gfQB+vQrLcWgOM/RJ4uGyMgW6FLaspMUFebRa5K8I9dY/P
         Ge+eKycUPR1zU6p3DEGSifo0UFZwfa7KuZeEhwg45K57pc92zRtb72bDeNztTz4Ra9Tq
         p7KhqBBJAS/dyOVOCezpwY8GhDLtCfcrtCBtOEr6IBLdW9KyAyWKbIK0G7L0IIolggao
         6a6w==
X-Forwarded-Encrypted: i=1; AL+hErGfCTrimNxxpr0S/Hf1qiseXYI0shPIYS1iHzmzG8Xvuws4zXIde25yzm1kcryRXw43M3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WYn0NqWWgXt7wDXZ8p5/n3+92jpx/TSxtC2iaJ4qbKV31si0B
	S7tA3pgEb6QssoBTPtSUM04r4BLv8IcDwSf99nQJ0wc5eQnK7TumwA+iX2umJwBP5rRACR73p3O
	TKjTCsyFVjHVucy2SIXV07rlF6D5hCbfnk6YgYR0KdFBIeKXltKnX8OywIGhDmd06jCqLMETxtX
	OywY+JUYF5wvEMBhEUzLUB6KB0UVRA1w==
X-Gm-Gg: AZFdTZdDMa2KO4n55UFMRhS/6WmAkSen0QK2ySO4JO+VfhT4C3Nvld1YMPw5Kg8ThhU
	EIeAl9YeDqFDHFV83uRiwt10Wx06qKKINmzrfhhuP4O7pI5XLSdi3LJB1WuP9t7YQrL7FXImaUE
	mT9CC15geirndysCpeBEiRJgH37TKuB7ZVjYdjD+qa9f3AHqIh4yqSXdUElwmftPbOwyeLOSHZg
	RMzsdcB0qqeiMCjnk7D4AiJqCoCHFhVGnGzkwqD
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id 956f58d0204a3-67df447c2b9mr2926869d50.75.1795505874941;
        Mon, 23 Nov 2026 23:37:54 -0800 (PST)
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67df447c2b9mr2926857d50.75.1795505874551; Mon, 23 Nov 2026
 23:37:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:37:43 +0100
X-Gm-Features: Aa3M54q5vxZ2pH5GHxV6_gcu1Tnc83EBXhtYw1pJ9H77Fl7U3CQoqAKpEumRrbk
Message-ID: <CAGgiveX=Z5gS7iJWBanyysVUStDRbgTnVktQwJySXw_-xL+sUA@mail.gmail.com>
Subject: Re: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX39Ovb7/vZqUY
 Q4U4pmR5LD3+yyYiSvJOi0qAa+eesJw4IjhdEyo+0JTWONQdAkbBn9MoC3+i3COOyMnWCf1P0Rr
 +KAntdV/dq0B32s7uuOuWcT36YxoqBo=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b053ed3 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=97S62Xg_vF6B0O42EdoA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: dge7-NxDc4h8GNL3FI5Jfn_VJxCe8Chv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfXyeapDnkShXiZ
 JQUAurH6EW3ZkG2nkDzfs7QP0a6Vz/Pu4NRSC3LkeiEWlkwIxrOoB/yLAXceD7WYQUcONbWpDC7
 4ALcJ+uJ5Qdpw6BW4TXphsL/04PkdEvDYUauneX6qeOINS/0ueWcYMfM7WiQwvgxRA+biflYSu0
 GCon9x50MUoMZhqbqzrHt8GgUJ5SfcjS7AXOgsyL/p/31STsRFCgM620ryQQflp10XilkrKVjDV
 +zrbxRcFd59/jfoFa0jbLO92aQHTAANsIqigo9ggqnOYZfHa7pfiig2wJXoGNlppunfIJzEuQs4
 kWqlkYPusjxnAyHAw4STyD/Y0LVQc/WSTJ1JZNPo4RTVvdvj3k2fCwj7W7rDqYDQCCFt6iuOPSh
 BPQLaEwVHUFWxf1FAjH3UHkI5BsR5q8ur2nQGUxScoQHESlVCgqKs1ZbFPALRaK1q9W8+Wj7Dop
 VPEzAzsQDqmwuMiU5cA==
X-Proofpoint-ORIG-GUID: dge7-NxDc4h8GNL3FI5Jfn_VJxCe8Chv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030

On Thu, Nov 5, 2026 at 10:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> PFN remap mmap action to map the shared memory.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  drivers/tee/tee_shm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1e089e..8fcbf0232aeb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, =
struct file *filp)
>         return 0;
>  }
>
> -static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> +static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       struct tee_shm *shm =3D filp->private_data;
> -       size_t size =3D vma->vm_end - vma->vm_start;
> +       struct tee_shm *shm =3D desc->file->private_data;
>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> @@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
>                 return -EINVAL;
>
>         /* check for overflowing the buffer's size */
> -       if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> +       if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> -       return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHI=
FT,
> -                              size, vma->vm_page_prot);
> +       mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
> +
> +       return 0;
>  }
>
>  static const struct file_operations tee_shm_fops =3D {
>         .owner =3D THIS_MODULE,
>         .release =3D tee_shm_fop_release,
> -       .mmap =3D tee_shm_fop_mmap,
> +       .mmap_prepare =3D tee_shm_fop_mmap_prepare,
>  };
>
>  /**
>
> --
> 2.56.0
>
