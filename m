Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94428150F
	for <kvm@vger.kernel.org>; Sat,  2 May 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777726271; cv=none; b=AsGfW/qhf5HtFmYOjFuuswUggIV96jH4b4xgJ209h1sP8RRgSovp7+LvSUV3TE1yRPph1v4jNWl+g2I1vxvEPAYepQWCdBroUtgCsYy49AZkf5ip8rgJ7Y5w1hfBkhl7a+fDvuRfZ+DCwIrIjXKR4CE04QjfvpO95alDKKqOLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777726271; c=relaxed/simple;
	bh=+yKUsr/aVPD0ObXjFZ6lH1CQ5V1cAs48MV1IUxuW2a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW9ZFy9GV+xc7bPUcrJsogIIhshroTvH8qlLb29GNONJ4b9OByz6hC2/muU28xa3oi9y4XkkMz6A2APkvehT7EejLOmrRIBPjlTMuvcUu8j/BT3dpdE/+aokYR2Qz++RWkZS1Q3R+0YekqRMGLGz8PsozjFQE+w55HTGI9TO9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoTpmsb7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoTpmsb7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6425RH612144343;
	Sat, 2 May 2026 12:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=x8inS8aihfHD2bW0tMLe78/yb+aafg
	CTu/knZGHe/5s=; b=HoTpmsb7LDnrCo/JhJ2VnP+tygmmUCCZfBgMkzDUoB71jP
	4b7O7FgpFGSRjrSQGfFQoWzrb8Czk694RqSgxOdC6EDBs8kWGmc4inKp849axboj
	6+6YE5BRBCGK1EYZFgJNhMGd7Muurv9wifnzsAb8Zf7bT+haikiWWbbzo9IsVQro
	0H+r35qCcLCLhCK8qd7CAuc3vT674bVlxo8w4/WVALI/3v6MaNeSccVmlHWX5huw
	SQi9DgpgxRhRtdt6wjIgYMvmPhciaag6l/XOpQXPICmxBQEzdhdrTI7lbpbm5K8E
	C4NGlPfq/wLhNhxUS8AarfTb9LmaKlKlQHOj/M/A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x490pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 12:50:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642CdTf3025838;
	Sat, 2 May 2026 12:50:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dw9gvh6gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 12:50:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642Conmw30212836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 12:50:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C634B2004B;
	Sat,  2 May 2026 12:50:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E733120040;
	Sat,  2 May 2026 12:50:47 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  2 May 2026 12:50:47 +0000 (GMT)
Date: Sat, 2 May 2026 20:14:09 +0000
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] target/ppc/kvm: Use host compatibility mode for
 nested guests
Message-ID: <20260502192312.57cadbe0-e5-amachhiw@linux.ibm.com>
Mail-Followup-To: qemu-ppc@nongnu.org, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
	Glenn Miles <milesg@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	qemu-devel@nongnu.org
References: <20260430061333.37905-1-amachhiw@linux.ibm.com>
 <20260430061333.37905-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430061333.37905-3-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDEyNiBTYWx0ZWRfX/yAmF0/ptXDT
 KnW7EEXXC8W5fSjG3vNFbOIE2lX3Ju5GffHDAAuGqakaa9Izps65LvOS4cvUoanRj0xHeM6TrCB
 /mLc/PPwrYSkiNKXtDM/SaFl47VGzMBVbozwMO/bqHSAltt88Wq/mccb5UG2qBEgb45I//rJdNn
 VXfm/TpWiFiZEzJTp5Nid2tp9KsBIzEl09f686rTP9Oc6vlfYxHLvRnfH60zrl02G6bfhcDasDT
 yDasEGRzIKQEZMwt5/2I1ujw8v3E1EzI71H39t3/Np12AM9o3MRzELQ+fdmIr4/ufguUJVnyIJ2
 GSpPY5xOSG1IXRxzRF7+bRD+81TS3bI4VMhT+K3zbRaaOI22FiLsAdY+1zDB9ATGB0c7x652ogK
 rSF53tBrcVjHFeeDmorLxpFZ9NmfwvMehrQOMOHCb3Q+Tf5QrLK6l9yf6h5P7Ymb4ckF5upRbRQ
 8LYTESNhKkyUrlfMNBA==
X-Proofpoint-ORIG-GUID: xgmT4qg-SonCS1evxNXf8bVgJ92ACqp6
X-Proofpoint-GUID: n5zQn4l7lgKTwKP9IE0MJFFOuhES9Bm2
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f5f32e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=EI8JAjJv2T8FAu73W3UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020126

I found a compilation issue with this patch when building for ppc32. The
host PVR constants (CPU_POWERPC_POWER9_DD22, etc.) are only defined under
TARGET_PPC64, and since POWER9/10/11 compatibility modes are 64-bit only,
the code should be guarded with #if defined(TARGET_PPC64). I'll send v2
shortly with this fix.

~Amit

On 2026/04/30 11:43 AM, Amit Machhiwal wrote:
> On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> a Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
> 
> When running nested KVM guests, QEMU currently derives the host CPU type
> using mfpvr(), which reflects the physical processor version. This can
> result in a mismatch between the CPU model used by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
> 
> In particular, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with errors such as:
> 
>   KVM-NESTEDv2: couldn't set guest wide elements
> 
> This occurs because QEMU selects a CPU model based on the physical
> processor version, while the host operates in a lower compatibility
> mode. As a result, KVM rejects the requested compatibility level during
> guest initialization.
> 
> Add support for querying host compatibility capabilities via the
> KVM_PPC_GET_COMPAT_CAPS ioctl and derive the effective PVR based on the
> compatibility mode reported by KVM. When available, use this
> compatibility PVR instead of the raw hardware PVR when selecting
> the CPU model.
> 
> If the capability is not supported or the query fails, fall back to the
> existing behavior.
> 
> This ensures that QEMU selects a CPU model consistent with the host
> compatibility mode, allowing nested guests to boot correctly.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 25c28ad089c6..d384161f780b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2602,11 +2602,63 @@ bool kvmppc_supports_ail_3(void)
>      return cap_ail_mode_3;
>  }
>  
> +static target_ulong kvmppc_get_compat_caps(void)
> +{
> +    struct kvm_ppc_compat_caps host_compat;
> +    target_ulong host_caps;
> +    int ret;
> +
> +    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
> +        return 0;
> +    }
> +
> +    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
> +    if (ret < 0) {
> +        fprintf(stderr, "KVM: failed to get host capabilities\n");
> +        return 0;
> +    }
> +
> +    host_caps = host_compat.compat_capabilities;
> +    return host_caps;
> +}
> +
> +static uint32_t kvm_ppc_host_compat_pvr(void)
> +{
> +    uint32_t compat_host_pvr = 0;
> +    int cap_idx = 0;
> +    target_ulong host_caps = kvmppc_get_compat_caps();
> +
> +    if (host_caps) {
> +        cap_idx = 63 - __builtin_ctzll(host_caps);
> +        switch (cap_idx) {
> +        case H_GUEST_CAP_P9_MODE_BMAP:
> +            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
> +            break;
> +        case H_GUEST_CAP_P10_MODE_BMAP:
> +            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
> +            break;
> +        case H_GUEST_CAP_P11_MODE_BMAP:
> +            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    return compat_host_pvr;
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr = mfpvr();
> +    uint32_t compat_host_pvr;
>      PowerPCCPUClass *pvr_pcc;
>  
> +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> +    if (compat_host_pvr) {
> +        host_pvr = compat_host_pvr;
> +    }
> +
>      pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
>      if (pvr_pcc == NULL) {
>          pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
> -- 
> 2.50.1 (Apple Git-155)
> 
