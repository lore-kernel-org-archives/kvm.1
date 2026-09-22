Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7B39E177
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117383; cv=none; b=FI4Vvqm6iq4npHxJjIzfJfjTtBTNibyf6uWoUQ6DifcgN9r7bBNMspAId2bjj1CoO0GTY9KnCDoqQzdFhfJ6c1RYLM4C37tkyLfRcMBlxBqKQMQImE+KjwAh191JS29oWQrFvoMF6km7IdKnnswgFgMprbyWUO4QgcCMgVKziNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117383; c=relaxed/simple;
	bh=qNzbdmq/oIh1lUZzfllq5i//OOvif/27x56ElsknR7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTNRy4waeYqkiVfz7Iapnsz1qwj0tA/XMb0jZ4CQqgAo8XYImge+2ac3uURzu4S4XjG87HXp2lbVmOkhmneFLfBPNOQvyk74X8OC9cbsQIlviU1MszMnpXsooX1T4lJCOrxMvYDmSXlbfJaPYl3Wa4sVdaG8BDTTkisnUoGWcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7DvbwpJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e/KrJ9n4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7DvbwpJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e/KrJ9n4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MJDENm1166951
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YorCO9U54gBbhM07YPBvezJSmHCc/9vnYs1YoAkAYVM=; b=f7DvbwpJMVDR7TMA
	P4ihPwzr1H6UYxQAMTawgCVJKNVtvcx4mE/9wflDq6mZ0GzO12c1imrLERwRAkl0
	nncQI5NA2EGyXi+9w1GA5++uYr04LbF5p+Ei/e8yy41f9Blz/+Dk0fDN45qgW6/f
	fTTbV5ePWcBvcJrC23PtMtbinCFVQvsg0JEl6VxcngSydKegP51NJG8iEOEcBlc/
	w5XpibGZsyfPemv/2izCojD9X6Zy802NjSVqZGkuJuiT78BcSIgtN2yz2UvN1X9T
	dJfdZ5+yDZS8CMMGUza5KrTYsutWQFYdXn74/ZdNRWbJXyDYyRKZ7xjTtIWufkUT
	QN/Cpw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guymw0y2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:49:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso310178eec.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790117377; x=1790722177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YorCO9U54gBbhM07YPBvezJSmHCc/9vnYs1YoAkAYVM=;
        b=e/KrJ9n4qDnTmuooZfvygY8ILiO+PcX7qP817Z4+E1R3yFJt3wfIFzZuO+VBiHAkDP
         Pf//8Db2tBcjN4HQ9m6rvsC32xfdYoAqbaU00vIwJcf8CZYnLci1R0Ec50QlX6AgaruM
         7sjxvXpWqyZd3tJfJ7UzKV5PrBjvYSg3D+DQXNFzLt8hmIB8nggk0281Q6NjwYx5eL8E
         yIIHJXRYiHRi/XorjGpY7/KsPgU8OcKyWY1NjGK0PP3CSMk4OOQB0waVc6AoqSyccI+H
         Q7UlFpEtwIs47r9KB3A+0/i3lJIRiPtiAexbV+PIJQo6Hid5qcEfEQpKcHWPQ154LeK6
         0zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117377; x=1790722177;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YorCO9U54gBbhM07YPBvezJSmHCc/9vnYs1YoAkAYVM=;
        b=mzxqkplYA3wMWq1q/ZUHfEy6GU1gq2zGE4PQJoLSQmNq67A1W7lncTpDRdFImfGkkj
         ACfGLCMZKEWIc9QZ+jHVj5zpNEKQE784bTUx/7Rl3oT0Lt2H4SoS18S6xhuPSQcTbej6
         o3plB2qNoT6K1z0Vrvyr7k2W8qwBbom4EAQzgJZgPdrzE+08tsfNf/uAUF8dkYc5EJUx
         6R59UbRQB63qE+fA20+K9tHoUDRiw0TAXyVf3d2/yJbxlTXpdFJzIF8jWScDBONcnOgW
         9GI99gXxw4Oi28MWOaBRpCH8oAuIp6nlpRE2b2oPRepP0/Y/6Y9UfMG0j/umsnb7ESyk
         tqoQ==
X-Gm-Message-State: AFuF++n8iVZCtNyhooSal8+rNczAbBMtQjVOPvfFVnYDbXbhbeh/ntrl
	yrAAD3HCsEenaVWXIsS1/4NCS8dCVc7+ydaUoGGK6bYM6EuGAgPzcgEI19M80l/z+GtDX8jPkXM
	PhxbMzvuSsQBirmwXJrkb7oKRmuUEn8LbR+er33FucwkEEwULY9rTuuiUBTO6/D8=
X-Gm-Gg: AYBFou3MbHdiLJZx5wdlXZgjUTpIlEVM0aU2mmlK7XMAwZl9B25eTWLs3lPz5Ee/P34
	zQ77vTZRt6/UNr/TuAbY8DG2rba60GR2lN7CEborLkqYkh3+Sc/FAkorns0A/87vE9gQHswnOZF
	NtL3SmbS3NeE9N5y/0Pf/0H7npC+OdSgZnP4eUi6EQBjEZS0O6QvNjFEdtWm4n7sG/QbAHgRqJ5
	rcJokL/RazOq//DRFo9netOuOMCoq6cYuY91qcFLY6F2Zh1AGFvFwYRFt7TfWs37beW0sx8ENUm
	LwQbsn0eehDRFnGHwqfHbEsgeVDtd31YoFgXZv8CopRP5r67m2xFjoHd9O4sNWGKZ4T0UIkCaG/
	9VSH/pZLO/elwPdWjJ919FFn4QvkVFPdtSrpICI9K40P+//Gc/RW3MNs=
X-Received: by 2002:a05:7300:7a8d:b0:33c:1941:8f8e with SMTP id 5a478bee46e88-33e5ca9fdc9mr916112eec.13.1790117377242;
        Tue, 22 Sep 2026 15:49:37 -0700 (PDT)
X-Received: by 2002:a05:7300:7a8d:b0:33c:1941:8f8e with SMTP id 5a478bee46e88-33e5ca9fdc9mr916091eec.13.1790117376769;
        Tue, 22 Sep 2026 15:49:36 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fe502sm1214322eec.2.2026.09.22.15.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:49:36 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:49:31 -0700
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
Subject: Re: [PATCH v19 15/20] KVM: arm64: CCA: Introduce Realms
Message-ID: <20260922154931.0000171a@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-16-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-16-suzuki.poulose@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX9IMKqjKSdiwG
 pZmw8XTJ6EL6KhR0vrGqb6wtN17haqjgoii2Ye0bp+KecjqMvXQRvCVfIZpeTueoWWksnL43LfJ
 mhtotnBtT6NPfLHJRtsfgSM9lWABqxIBgt/vGiUxSS0ZyaAekLTAx/jdZeOK0w0YVYg3yGc/gIn
 Ondg4R9OsZnoPzuCRVfxlYW5Ym5y9cQAOQzK6kP7Xk+TdOXMZkRL5oAqa1/mbH5ux1JYPYMuuHF
 NkZ372DO7q5kw8pHrWnAXMMpP6sEL15CPbTIRe75/R/CwFpXcLOeODSPdPFoZDiYP8+U1EY1Sdh
 WHH5mjK7WaatfL+wE0N9tKcLNDlizfRlOTbZXXbshUKKEQlb7fqeqx+hzUuSSqBhmz93bZ45I+R
 A/5jBDlihgwIEjhTkkUERnRaElmH3dsDqsw/HVO4kwUJx3hE0XHKFAkvH7Aan0QouN/CCyOIXem
 OLgsH+VUjRsDlLJUYOQ==
X-Authority-Analysis: v=2.4 cv=feI4WEQF c=1 sm=1 tr=0 ts=6ab30602 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=1xClAnr3vSIPrHROFcAA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: a2kfYGq95v8WAgN9oaMj5K8mnZMCP67A
X-Proofpoint-ORIG-GUID: a2kfYGq95v8WAgN9oaMj5K8mnZMCP67A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX1w0BqahT2k+Z
 qWo0r2SWwE6bU3pYgW/rX+INuErPhe4Bu1KfJ2oLjXvHX0XjXM4d2bLF2mhR6Tol2fx0XPb4WXG
 jUxFRBgWgRQFwICaJJOURvW+liqcBUE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220303

On Sun, 20 Sep 2026 22:28:40 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> Add foundational work for supporting Realms.
>  - Add a new VM flavor.
>  - At KVM init, check if the KVM can support Realms (though not functional yet)
>    and will be advertised by static key kvm_rmi_is_available. This will be
>    turned on in a later patches, once we have all the bits and pieces ready.
>    For now check if we are blessed with KVM_MODE_RMM.
>  - Add realm specific tracking in kvm_arch. Since Realm and protected pKVM
>    states are mutually exclusive, move them into a union.
> 
> Please note that we cannot create Realm VMs yet. This requires further changes
> to the UABI and core RMI driver support, which will come later.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Seems like sensible infrastructure to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

