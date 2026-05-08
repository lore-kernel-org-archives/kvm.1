Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D731F9BE
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217654; cv=none; b=P4EWA+uH7+C6U955j4udgQVi89sfMwfXOcSagy9vrBWraHkri4yrCQ4qIXD5WFZEBl1y4xsKNkyRJYoeeNiIGwBml1f9qg/Loqsy2xU69fakcuFr1V8qFstsI866yAhkccHPhTVdGauukIBgTH7FlUrvc0wc5t7EUeHsf1n66BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217654; c=relaxed/simple;
	bh=rD9sahxFrHyQ5DXOJuc/HsRnrxWRWgDuiRmYE18kl5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIrmtMF/h7I7Iy7FZUXeftz4sDVRWN4XgnqSJj7K7gZ4+4fIsMxqK622766dhEkHrn5tbBqqxyJ50H3X1nl8G69XHkzMrPDa32PpMGvLa975d+8M1VmDlLRcMUIgPp55yDI+AtqGlMoKVF3Yo1az9o62S4/qknTxF3Z2NmAGn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IIceTVE1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IIceTVE1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6481gemX3054710;
	Fri, 8 May 2026 05:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vdBhJRcBsx8IS+gSnfz4srUODkEBB7
	XwpQNMvxINU1U=; b=IIceTVE10FHizXqNmsGP36LWeBDj3vMSWsKRJovrOF7mDp
	jxkqUJDcfAU5t7CccQTXjGIdg7ofEWpp44+rhrdkXgCQTWX+8VVARHg+9dyPdRqX
	rpTmIO8Mop0wVqbsOL8wfOauQYb9Ci87jNTt6rJlfH7DnRZ4SMTokh6X7FshHfJL
	O8aM9dvS8w3PcyuwViwWsNu5Yz9oEcgmg6aJVxYtEFDGZAyBnRnXodPJliQR0U/B
	664lUKaVqEKNZI1gAeB4VxopIojOcDxDdNa0vjA1+ahIKtbKq8L2bq9bLdRSw5WD
	WsDU20CD1lTywRfbg3gW/Kg+7mbYHDIcci+RA/Sg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x525tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:20:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64859eWI011344;
	Fri, 8 May 2026 05:20:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgpnc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:20:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6485KewQ53543210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 05:20:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE842004D;
	Fri,  8 May 2026 05:20:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0BDF20040;
	Fri,  8 May 2026 05:20:37 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.47.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 May 2026 05:20:37 +0000 (GMT)
Date: Fri, 8 May 2026 10:50:29 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Message-ID: <af1ynfIuksZKDFau@Gautams-MacBook-Pro.local>
References: <20260504134344.38958-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504134344.38958-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA0OSBTYWx0ZWRfX/2Np0g79jduW
 Ow5eVQm118ZjThz00U7GD4B03ye4SCne1ePPXj/eDmRwW+PKx4Zb9Gjt0XKq2xIeslO6QGHHAFI
 l+Uox3oIXgyogfNK2L+sC/HQ1Fi3CXUlAVg/Yc0Yn+rZbBOhb6UAv5hvXwIpwbaO9Rt9lQH9qJm
 kU0238fZJq9XBst0p21foeH64B/khixcEcR8XUVoUx4PeayQJ8jXsjNWIpleqoYkpi4ED6Or+b5
 HVT8Acv1QVPgNM7aC9MQs4hzqSloLmSTv+jI6qc0GtxVLG7bDPjbknf5JGFrmKbDr/J48gXPpsz
 KOctbyfPMzYd0aBqujy3cEbkutCxPVzK6P1PFDMvrSkYAdvEo6f/bXG6pxX/gZNSJXDQaBoWl9+
 upu8OGxnGBppwEKLV4LPIvv7PnppuHvPqzdTVZ82rkfk3PK99ECeaagEJ/yxeYWRTZ4nxSFrC0u
 VfXopav3CiL5fBQ3pZQ==
X-Proofpoint-ORIG-GUID: CVpvcJO0hoDQ1xrGwgStrkDN6VV9mHBU
X-Proofpoint-GUID: UHkQeoXTIPbA9s9o_qnEXzbIIC3Dm9t4
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fd72ad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=fgeSLxjb8Jst0M4AXQYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080049

On Mon, May 04, 2026 at 07:13:44PM +0530, Amit Machhiwal wrote:
> GCC 16 tightens diagnostics around const correctness and now correctly
> rejects attempts to modify strings referenced through const-qualified
> pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
> is defined as const char *, but the code was using strstr() on it and
> then modifying the returned pointer in-place to strip
> POWERPC_CPU_TYPE_SUFFIX.
> 
> This results in a write through a pointer derived from const data,
> triggering a build failure with GCC 16:
> 
>   error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>         suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
>                ^
> 
> Fix this by duplicating the model string into a mutable buffer using
> g_strdup(), storing it in the alias table, and then performing the
> suffix truncation on the mutable copy.
> 
> This preserves the existing behavior while avoiding modification of
> const data and ensures compatibility with newer compilers.
> 
> No functional change intended.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 25c28ad089c6..e71e5c0117da 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2654,10 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
>      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>          if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> +            char *model;
>              char *suffix;
>  
> -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> +            model = g_strdup(object_class_get_name(oc));
> +            ppc_cpu_aliases[i].model = model;
> +            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
>              if (suffix) {
>                  *suffix = 0;
>              }
> 

A const char * variable is ideally supposed to point to an immutable
string. But even with this fix, the string that
"ppc_cpu_aliases[i].model" points to is being changed after assignment.

Would the below diff (untested) be a better fix?

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 41bd03ec2a..a84e4b4636 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2654,13 +2654,14 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
-            char *suffix;
+            char *suffix, *model;
 
-            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
+            model = g_strdup(object_class_get_name(oc));
+            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
             if (suffix) {
                 *suffix = 0;
             }
+            ppc_cpu_aliases[i].model = model;
             break;
         }
     }
