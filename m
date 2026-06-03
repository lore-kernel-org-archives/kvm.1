Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1A3382EC;
	Wed,  3 Jun 2026 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457682; cv=none; b=OTQic5u3TEp2FdQObHPZK5T166am64L2lGK7G5vcdDR0925xDenyFVyjYs9AYg/REH5cfpv1Ez6g7Hcidvkpl6qgqW9U+YVlCfyPMwRut08nYUko6zlrAsQpkAlaWiBOqH9l41lnbk2RoLQ+eODgB6a7m+B1iymx0DblmO3vWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457682; c=relaxed/simple;
	bh=CNXwDBuPWxCiTXQMyKkrUawMivbKCJlmbJPtmkawtj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsBUGI9cUdr8XXtcMStE7xoQBQ+3wYvB84yRfCH+l1U6bUJkl0dIeMfvK7efhR4+e0als748q9qVqodhPmxQs6ztmGIZWlEbOyxYsQMLAOFfMyrHm42l6dCBZltMAeB4OQGRFkNK2orWVECXrIDSR4LiqJeh+YwsKXPV2EZItK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WtYtN8AS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WtYtN8AS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EmiWO3294112;
	Wed, 3 Jun 2026 03:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tqWImsXeVRKcQn4dWrEUOR+IcKrbiN
	ifyqEYRdi7jNg=; b=WtYtN8ASEBEPkn6FsN53lP3roAJ3tWpikSj9WUeqLVLF3y
	M7jbEQ6anQpUe/dUMAR9Or69H3PW3Qa1ultcFE2qNFdyCcTRaQdj1TuUtrXiIxDI
	4f3qQOTU/2S/kVkRcpjs0Hj0Xp2uCp2LVrXoFcZADKailDPj4R+borZEmDTEmdCR
	bxt35Km8Sc7WTzV6wuMXcW/u415hsY+/zusXaFXebyQOfcHIBsE2FpJ2aQuzkIS1
	hDhPQV7bM868zNV7Kc2jwNiApjuQ6b7hdfZ93WmFdoSnhryk6L9cJvmJxKZQKK3v
	yFn5P92d+v1YNrwOVQcFHY3oM7v+F6GkZpQqs2JA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahrnt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:34:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533O731030901;
	Wed, 3 Jun 2026 03:34:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvxet9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:34:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6533YIZ319202700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 03:34:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7EF15805E;
	Wed,  3 Jun 2026 03:34:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6545E58052;
	Wed,  3 Jun 2026 03:34:11 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 03:34:11 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 09:03:37 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Amit Machhiwal
 <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat
 against host compatibility mode
In-Reply-To: <cxyewhx8.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-2-amachhiw@linux.ibm.com>
 <pl2g6xbz.ritesh.list@gmail.com>
 <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
 <cxyewhx8.ritesh.list@gmail.com>
Date: Wed, 03 Jun 2026 09:03:37 +0530
Message-ID: <87se74z4a6.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAyNiBTYWx0ZWRfX1tX0qYxhX1PA
 z61jkOAogx672D97RkbkT35H97MqtDMjEccbGEYfzy/edaCFo3SHcOTzQbIR7Qb7kGc0g/WACI/
 lnfSlQwKm6TpwvMH9LmHLTp40/SI0ry/41/xLbP2yyAVdF+VpVeHIwl48qdwyQioYjEAzNCfaN6
 4uu9B7Pxwxt7cq/RgP7mes23iULTqpN4KHTtbtrLOenk1tRC6Yf7tih1rL44WV7MB3/UHiYxcfx
 lr7xcgV6K7jQSLEXn7OsmMYdwweBBIhdaTvVLAKc4aux2R7UaFCcrzNmqU8oWGwiPIyaHbJQhxM
 tOm4aVIV5neqvvnJzoNyzoDE65ELo2Zcd+hjiNDoKEok2Ylqzie/ADIhTuAyBcD+oQcB0xkou9N
 xO20NMfJX7obb+6noYrlsMywDr4iAYDhqrbjHxI7aLTdg4u5ORMZN+0N7zXPvVgHtQ3p8PnhWfI
 GpYBlNCUX2LJy3icM9A==
X-Proofpoint-ORIG-GUID: tlBea0HN3XiMzJQ3-isLDoPoncieOJQe
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1fa0bd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=3YTRlACzSOsmAlwpqRgA:9
X-Proofpoint-GUID: tmgqI8U8dHULBbb6Z5BkVT8DMOcv5ZpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030026

Hi Ritesh, thanks for looking into this patch. My responses to your
review comments inline below.

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>
>> So, we would still want to prioritize the whole series
>> instead of just this one patch.
>>
>
> Patch-1 could go as a bug fix even in 7.1-rc6 (or maybe with 7.2
> bug fixes). - Maddy?
>
> So, you may want to add a fixes tag and maybe even cc stable if you are
> seeing this issue from older kernels maybe when nestedv2 got introduced?

This isnt a 'bug fix' per-se but rather strengthening of compat mode
checks so that any non compatible PVR being used by the VMM can be
caught early. The hypervisor anyway ultimately prevents non-compatible
PVRs from being used by the VMM. So there isnt a bug thats being fixed
in this patch.

The rest of the patch series builds on top of this patch to advertise
the available compatible PVRs to the VMM so that it can further
preemptively prevent users from forcibly using a non-compatible PVR.

Hence IMHO, this patch can be marked for stable tree and potential
candidate for 7.2 merge window. But dont see applicability of a 'fixes'
tag to this patch

> However the new UAPI discussion might still require more discussion with
> the community and I don't think it is ready for 7.2 yet ;)

Somewhat agree with the above

>
> -ritesh
>

-- 
Cheers
~ Vaibhav
