Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2551617D
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117629; cv=none; b=Eax/++CDD+F8pB635U2dsodr9EdHDDWjRDrK5yEQCajvo0xCjKdOcZRQaQwJ9+9159ObbZMMDHY9D8eKqmC3nZ0bhOGklMAExUc4YH9ICYnUZg0XIA7X8qj4UcBBhqumW/VUlt0cEWaoM5mlkGmwMVYbCVHLBe/cZ9wtpy+Yyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117629; c=relaxed/simple;
	bh=343dUSnYOysjpy5fyuWntmT3fKeHN580Y5d1wxsBcrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6nlgDtnzzHtvkMTYWDrrIv45pQsKwOlzhRyUzzqU+kLw9Mg3IjeWKEyNNLSI1OFVOvQTltsI4AUErbaJ+6NnvH8yqywNJ2cm0LDGNFUSHSOAvkhRpKVXj7tCAH3qxiAE2GxE+xQq+pbcY7AAcs1AOcbJ+yEBHxKnFivllM84lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0jMB3y0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EGGekFcI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0jMB3y0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGGekFcI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MJBeJB3897562
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ij3pQRHyLZbZtGm1WSsSpgH2KR2KK6oLa6dVIzgew98=; b=T0jMB3y0rL8j0v0n
	uLQ9L1ct+DF5ggyvqScz234nKNMbEy/2euOzbMqYlNwebz2EMqzizBoskOik5kaf
	5OJIIYXDaGGMxfc/PbxdMF/xa4eAmIHoSu9t2LwPE/BrNcUHf687+RrvoMq3mckU
	/ss+V85KBbnPpfroU9jjsSPT4EiBw2ScJSrw60JNNHk8Q5KBD3+Z74OtnL05CGbJ
	2BeU8SYiC6J0gBkULd3MqUx1qpkZmxmzDe2RreJezeE8IQmEu82IDQQkZ3jzRuJQ
	Y0efI4/JaTIRCIlDteaRp6xaaXgm7pLAJ+UrhwjYelKZ63sE2RpbOoQaT9CkoG7V
	Rz3sNQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma0xh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:53:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-32850005b6bso351497eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790117623; x=1790722423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ij3pQRHyLZbZtGm1WSsSpgH2KR2KK6oLa6dVIzgew98=;
        b=EGGekFcIbY4V2Avt8/gB6+3uN9NB5PQmYno4D0569ZocGM29NqBz4SoWJS3Xmicxgo
         XstAwry+LR2lT3+5XrknJTFMFeeymdPZ8S16KxT0mw8NLzKwOu6cxNRW3LyieiwkM+HR
         BqHYPANpB1a6AxaBHn3MIbRXhoYMqir8CMcaT8LmQB+usVwHyevQDbVvCdXoGDR6Et3i
         vbh+79yoxFzIDC3ihZyH1NvvX93YJR1eoDnl3MibFtUU+JtMVnjgQDHyjnyTUy/y1M7B
         +dwt7nu11yFuP30npeQBEfovz1ek5jFrRGg86DEO7HNyND7Rb9Xz/x3d/eevqflW1gdZ
         4D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117623; x=1790722423;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ij3pQRHyLZbZtGm1WSsSpgH2KR2KK6oLa6dVIzgew98=;
        b=dEGv6DnfoBoTmhAfTeyyqUTINsodoUH127vx0xyMVmc8nd/bmL4bikas6AJYh5sX92
         Ex1fdC8Gv1wGGNHpCLHl8q4qrD1CArzotLRztVVmojArOQ6DugQ7JaRHTIqgHG/rWZ4C
         iBtef8nNQS0HAAQBfd5340TFWiLFQS3Pi4JSDwaafubZOAd6Ka0AajUUwFv5HCkAQvJi
         qZCzlrDoHAC3CeeHS2MBsGoFZOro7QIAQcUF7WJ9dLHDfd9vU8lpfLmuNoQ7j01gKQxL
         JswlUWCVB6LLNKM87esh+IqCfCFqq93Nqsge556cnvKiZGUEEwiXlcRBBXbKbMsfwHAk
         Vb7A==
X-Gm-Message-State: AFuF++mHKOfXGSe87U3f+v8M0mpow3/ZBeFxwD0Gvq02Gd/B0upYq+8o
	oGA6whRe1ewzDNihyn6gk6hdDWE7uKGrs2t8jTgrbIryN+5QWZ6eI/vh6vwAqPvxaHIXlEn/DoB
	mhQP5GEsBs8SZyHRowAeMzIvhuKYGwlAsxXFrOBbgFr9bTI3shV6uiGE=
X-Gm-Gg: AYBFou07zfnfPKQG05luTid8YP9hH5eQBtOTumFTOClD54LxR2LrrQ4WrU+FpWZlz+a
	xkWirZ9Rp8EY1yvxlJII1yQive7GIF2h+CCiuYHlxHqy1EoSnjzNeiB1Dm9QaQD9GiqHAb7m0yp
	/m75pEbTh4xebsprDog3y7JEFRVyNeLIZl/HR4vqrcDDtwtm0Y4+//MA73BNaSh4Gycg/CBvHdI
	7SqGGNbsqaKOLTzwsvP7DDrBYvez5Emp2mOK6BCeszBDpc+U09ezUhODwhJjqlS81w5pAN6+KEO
	yb+Jj2OCw0rBMDYZe5zlkQ9frb6sc2UDZJs4ySMSYsF3ZMkH02+Y77TNavC7Tw7/jbTOuRx449A
	nzvkzyK4F1pa3ujuRMxB7YPpuGjvx2gneGdlQQ0vAoOrYBLn9QAuy1A==
X-Received: by 2002:a05:693c:801c:b0:33b:ef1f:14b9 with SMTP id 5a478bee46e88-33e8c250524mr868840eec.15.1790117623116;
        Tue, 22 Sep 2026 15:53:43 -0700 (PDT)
X-Received: by 2002:a05:693c:801c:b0:33b:ef1f:14b9 with SMTP id 5a478bee46e88-33e8c250524mr868793eec.15.1790117622505;
        Tue, 22 Sep 2026 15:53:42 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96848e18sm1178819eec.17.2026.09.22.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:53:42 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:53:38 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v19 16/20] KVM: arm64: CCA: Don't expose unsupported
 capabilities for realm guests
Message-ID: <20260922155338.000064e5@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-17-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-17-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7P3dpupeeLhJjx7QJe49NTiBKcwe3n12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX1e/JbiAMofCG
 UQIfhhXPLoqVkNZCfWNKY1ZtLJQMOiuzwcpJs2ypxeovdmdpA+FOmnSbRjBEiPnzbG0NxuC42U/
 Fds/j4oJ754r2tUg1+D6ZyV1yMRbw9M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX7Ig5+QfzchtQ
 IXMF61PGcz2HN5iGaJjzVxRKCUkMlHNtVaY0ZO1dI1adcXJ91NtNQtguupwQhddZ9DYYOkd3vaT
 FV3iyer7sz4NVDnvHoNk06vA7EeHllkPh16+P9nkxbqTm/1BmgDPxkfQNXv2psHoa4hxjbtEW4T
 FpH4cBrBgYNyFiKIksms9Hq03y/kGPcCeURoUMjGuk4obZaeQaI1a+s1yIhRTOSfmioW+yQ/z71
 BXQaOSh+cm2Yc3cvUb1t53o4+vQajQlNgo7LPAfV3JS3ERAEhlazXq80490lFmf3iQhYqZ3piQA
 K04wLM/w+C2fcmft9wqi+TqW9vJvEqzGICCqa+jRYJzVZAuch6NJcn6hl1OJ6U+vzP5lyRa5Z1u
 Gcnwg1pFabv/rdSQxaR4/F396p9jipxn248GdmhZGsLKTdEXSqBpOLe/Ug0yN+exNjsNNbHC14w
 gFNmNUyj+zritsq2RlQ==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab306f7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=z_NLTHdx8yjNkCs6FmoA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 7P3dpupeeLhJjx7QJe49NTiBKcwe3n12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220303

On Sun, 20 Sep 2026 22:28:41 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Limit the capabilities that are allowed for Realm VMs. Similarly block
> the vm_ioctls backed by the capabilities.
> 
> Repurpose the kvm_pkvm_ioctl_allowed() to support both pKVM and Realm
> ioctls. Rename the helper to kvm_vm_ioctl_allowed() and move it
> into arch/arm64/kvm/arm.c. Also add a generic kvm_vm_ext_allowed()
> to handle pKVM and Realm capability filtering and route them accordingly.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
One trivial - otherwise seems fine to me.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 86e705330d7bd..eab8543a4194d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c

> +/*
> + * Check whether the KVM VM IOCTL is allowed. For pKVM and Realm VMs, certain
> + * ioctls are not allowed. Further, certain features are allowed only for
> + * non-protected VMs in pKVM.
> + */
> +static inline bool kvm_vm_ioctl_allowed(struct kvm *kvm, unsigned int ioctl)
> +{
> +	long ext;
> +	int r;
> +
> +	/*
> +	 * We are guaranteed to be called with a valid kvm instance, as the
> +	 * only caller is kvm_arch_vm_ioctl(). Catch any deviations, as we
> +	 * rely on the kvm instance below.
> +	 */
> +	if (WARN_ON_ONCE(!kvm))
> +		return false;
> +
> +	/* Cover both pKVM host and Realm VMs */

Comment is a little confusing.  This is the path that covers everything
other than those two.  Maybe 'Rest of function covers both...'

> +	if (!kvm_vm_hyp_is_distrusting(kvm))
> +		return true;
> +
> +	r = kvm_get_cap_for_kvm_ioctl(ioctl, &ext);
> +	if (WARN_ON_ONCE(r < 0))
> +		return false;
> +
> +	return kvm_vm_ext_allowed(kvm, ext);
> +}
