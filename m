Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215686;
	b=CEEV4ie9HVP2xeRjON6Bd0lpENi2EJWXthyPy/ibN/l4x7StyuSYOhbQpCrU33bC3Nfa
	 vdBOjZIp0x35WzhhVak2IVNAJPk3P6pbtzM3wo59RDZsQQVGFeupyNazKltO6inh8RG45
	 MTdUn3iTkKZofoWH34zLwDZU+WFWR+cJa69kkRlPX6Gf0mfF15IIkrQ3LXmalpRsQNLW0
	 RH0IKFZgSg5SWjt6nzECUPE49A6wIuYhmUf+puXpvp7op7NBXvevF8zgKloLugLpJA/yx
	 F19osglambHA2Y5+RetHxsBmelY/wcIgCzNMvsU2ULixDmfpE/Ogsi+G6JBY3OrjvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	b=uyNNPybrz4v4+UM61eBjqvsj0XAAdr16QgkRi0wgxOt7wVhI6FH1CDMD7HjIlxBQC2rI
	 8W4z9T11uyVZgxpg2whqX5ZT7Ct+g5mXKHHTx6a1IjCK90HJFIdLxsil8cH37G5Gd9Mdl
	 8ChbwZ5tp/6Ge1lROFelAiSOlbmTssq2JsWgIPR01jk5YN6mSZea2jEQvqchBYMqS8Eli
	 dzYAfN0NFuNS45FbPd5AiFRj8UQ1YMhLaVFfya7xPnM3HkD04MaV9w9oztOjazsRzXs15
	 jKatO3g5ULc40iydPB2Lu2j9tezDE1r0doUk/a7wUbs4ErrZrVI1AtozH507X/eOUkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRuWLWCd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD2606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 09:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FD2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRuWLWCd
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96ANin3634754
	for <kvm@vger.kernel.org>; Mon, 9 Nov 2026 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2gy9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso134961585a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215684; x=1794820484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=ZRuWLWCdtN65wuVlWtWaew5IbZJQV+xs/PnELoRFpgR+THgXzTvZHHOS6lp+q9i/63
         vG1RLNwSZy/EKgkhLioQy9BvJu6DTvuI72ZPuG8/ZNGhIX27xfpTPHxjQspokzT+CS4w
         mq2ipsL1uBiZh1A8Udd+SM9ptm9xaw9Aazb85UGx3wPDnivcG0l55rJLyxme0XB0pV1N
         ZQoZ1fCQPdtCa7a1K3weoQ5WiLHJL7xD2cFw93ILwjd1phhIsepjgI/zHFTyWW8S7+94
         YChlXmlDmtQB/vMWu+nkqRbdYGmnJ5OOssgzpkC1RENEguS4LhadiD01PH1aMyZUHojQ
         QMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215684; x=1794820484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=YCEfACL6MwEjSv2k2tiW0cg+SaVJHHdeOGhjEVIqhbET6zKce7I2ir4blyP1aNj910
         utwa5XrRNTA8FnfX92oqHx8ZBbfyYIIV1VbcXo4I8047pfXl7t5VcHNe3P2VGb68/0Oc
         1zvj+JMS4nQI+I8JDaxQ4VGhg7ORNQNhpFwjmi8fdiKYkR5QbV06PqObmLFHZYJgdyqm
         p6D4ew9uRvtPNFcX9+o+ZIuIB1gQNQ+bDYt7TD4mS3CGTr/buL+7r9kjVwiA4nk08S2Q
         Ak9qibkaKlTUouYYT3IPDBgYu2K0jdrYOFyxR/sCoh6HPSxBN7BjDarlbAN9sn7ewhYJ
         0zYg==
X-Forwarded-Encrypted: i=1; AL+hErE9aZEFSlJKiFD1zWWfDxZINC+yPWYRu7i32fhkvGv7DhMOFmfrJwuJ6iixVimuol82roA=@vger.kernel.org
X-Gm-Message-State: APuU4Z99KTTsNwGU/UFgFjwQJf6x4X6AmeR5vdYAPc0HRB3ZD+4fICZf
	7YduITlJT93mt9vKqJ9di4Vtqo53HF9RPCavF3E5pMd/YZSqhkrtU9FTUGeM/F2Gjn75sfTus1e
	6sDfzNr2IXVdlgByczRIxjuHyRsG/ececwA++7uju016mQqS67aJLBrw=
X-Gm-Gg: AYBFou0G5j/WA8gpjAvRj+pQvWky8sjMYA7EEqflFyxr7LuEMs+MQrSFiS8UGBAnRUZ
	E7HWE5cqRDGSRXpi7+OdNSsxAobTaVqijytajfnzF9JjTMYZrMOhO6PUjL0wj4zJnDYgadEDo4G
	b8P10t8fNyc19vgAJ4GkmmsDg4o02Nwvu5wsAH9Fvqv76VPHGp4YqeuM/4FanTSWc7YgSaDtF5y
	i2tkTvuq9IcYrf/p4oTlV0+69/qa6UkPcSRkrMNkqVj7y9qvyYIMzjYVPP7XzX7dOe5VSjzANoY
	sSK82xQKN/ILISh4SZCFKUHH561HdXIwl+vOSwC0+h17XX2FdIXDdYO5C9NMgoWMdl+sWkd86Hf
	RZomrfiDvFBg74xTZtHEX82VnW9nT9skIeEM8QOf7sxMjVahzdDSfgYz07Ik67ms=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886327485a.13.1794215683469;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
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
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX6YGbXlFTuZgH
 a+NWd0hdh/zIEEyRBVnMBNGUX6jVPxeu8rS5jUkAw0qdjs4M/Q5vRQ6ZTZGYsdXIUCNTQNg1LJR
 CPAyRbNzrjpzUv7chEFQVVBl9HTW/5Pwqe5PSAPF84jVKIOY031RFIm8QHkk3cvP6I9ICwRzavR
 rpQAOnSW5kXSqSDXELqoM/TfZrZ7EAXgpSXSET/oFj0xYlzaNw6eGvRpvV8AN5YHCYBYK72tk7g
 Pl547jUnUYxuGTqOwpMOIjGASWxnt8myRuPo0HXYF+7Ksge7DvWJgXzhMNH8yzYxgUqx1vO33aP
 pGSuQAmnViyMzrPaY6N28Sx8zfTrlCkj3pEF/sjt6CsA0NxXMRO0eysGyF6TS+psNGznIeqY6T5
 u1EkHJ+MtQLKhOtEPIEFSjeDjCQeM5rPOpMB2UMyKfKeOybeuGPDsHmpGdTAQfb5ZkmN4b+/dhZ
 i95O8bFGKE2nEBhyUGw==
X-Proofpoint-GUID: a4eMfyzFaUoC5W6ZXf3jLaJUo2j3-gP4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfXzbCsRW0gabZ3
 zMULAO0Ynt24JsDhL+Hq1n3MTIW75BZelZOFqy+KtVP1Qyg34BJ1DHV1DUhT9p6GczCjMokCiZM
 ft3DuhWCNyyjFIZeN7k015FUi1GiUhk=
X-Proofpoint-ORIG-GUID: a4eMfyzFaUoC5W6ZXf3jLaJUo2j3-gP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
