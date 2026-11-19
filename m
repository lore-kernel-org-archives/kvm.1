Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109175;
	b=0WnrzUfq9kMkUGu71CJo7JF9dA8DDIyGeZpVpnNR0B6+ntvFvuU7HPCcV2Uk9BSGdbDs
	 yg5nBQ8vXenJxnu+OHu2lYgXv//rp8cs1+vhpQTiyT1TKRVgQ5PiNv2mZa0ubVbOLPE1Q
	 xgzMh5UJaHgOEfv81FewW6e7xxQj2tY0QKI+ie3KmEo8rCPGZPkyZGAdJ+NSXe35QOhqv
	 YpVVmHhgmguNdF1SI4lNYRXp2nhBVhJM+JfNwgtZmWRLhLCiDcUznyf1H5+KyVuvrvq9k
	 TKNuZ64/FguqB41ebp9aM2IIrxOZV0N9taZ9JyEu3bvORqfbVeKAGDig7gf9CFlaDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=baTpZUjod5GD/amHfc55ByHpGuIJoaIfPWwl3/4IbyE=;
	b=MYAdIE8iE8sH/aOA36OPC32CdCGmh1DXa8JDye8qUV5slV9xG4U2rzSxP8vtuqEUnqJ5
	 ohsurUf6fwxusQhUhi6cvwuCLbwT3XjhGBl1Hc2J1LWmniaGBdQ2fjjyKdURVjYsE6mzp
	 Y18/vXKB15OAN7YXC+Yk+/GYjaCuS7Z9exfzk9ahOr0j1YRXvOsXLNJCF1q32wuhMG24s
	 YBfIr7aJo9ztpnJy6vRbN1sgaRtNV6ad3R91BW52O8E78fJC+JqYZdBj2vqskXxgbSifc
	 qLP6LcjoNDjXjbcp9taak/tJdiRLjVBhjYGx532KvxDWkCVUMSFcvz8S0m4oyYeTSbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CueZNpJ4;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FF606A324;
	Thu, 19 Nov 2026 17:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824FF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CueZNpJ4
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF8jD13256812;
	Thu, 19 Nov 2026 09:26:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=baTpZUjod5G
	D/amHfc55ByHpGuIJoaIfPWwl3/4IbyE=; b=CueZNpJ4YJ8ALUOc215uhnpE+ff
	dQX1OjfrScxov1md8Q3g97pe4M6hcrZzuOMXtkFx3ctvGpEvlfrGcahlwu1xyZI3
	ckBI3glM/YRXa9qgYAgrAWKmo6cVMaW8SnOuyhTFzo+YAyw145PDy91KLpeQ2ZfP
	dnVvv03X4rNsngwF+TDtjIVnHNWmLgNIoQdw7LlI+jTA6EYvC+JBIMASraK6fytM
	t976vQHHMTc0CZTxej92055SNoQmA3SWCgOJjkkkYWdZVbc8KaLN6T3MjPCFDs0M
	N7BlqPWCBD7KxEFhIMpzEWyA3EjwWdK9Xt2TNmZ7U9KQkdVnGM3n81aueyw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j1yjjk3ut-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Nov 2026 09:26:00 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 19 Nov
 2026 17:25:58 +0000
Date: Thu, 19 Nov 2026 09:25:57 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev-bot+sinfo@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin"
	<mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio
 =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Simon Horman
	<horms@kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <av8xJb3skp2S9a1D@devvm29614.prn0.facebook.com>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <179487315810.3291.12142099363352099423@kernel.org>
 <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
 <a3049b70-fae9-488c-9de7-0c1613e6c480@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a3049b70-fae9-488c-9de7-0c1613e6c480@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2OSBTYWx0ZWRfXzKS0vfGJ72KO
 zIyDazw0AxLGffzEGQwkkEj5SntZA4LKayi0WiUzH/ViegYsmljCHZt1zG8QADoL3QM7A/EUYZx
 9UMEmnD6ZoYfCXlJH2g+Bs/Vr+atw/164axcQRQ75ErEza1WtcY1k9dSHWptyH07MFjDK3i7YfY
 JCB4fmPNh7gmiVpgWclTMhLO2H4+fwUQJUUU8MWjMW4zPhFIMFFtU+PgM7deuUP0PlUmS29MIk/
 oXVQX5vX83mKiP8bj1Xj7SwK1UXU4WoPBiC2UcLlENghvHjM1o4rdpUr4UTGMOGEdM+bTAOm6BN
 3CfR/7gO+PAJPsKjx1U+Dnfz/R9TmxEzImwUWg0txQpwZKO7jdPKcLogyxCjtAyhflOZUw3m0JF
 eIyDZRhoOkHKmryiop+MQbllNzetpU89I15vZzADAtAl+dQKLz5QkLTVrnPz3g4ozpLCvRfMyBD
 1JUdORy6Vnqhn+beb0g==
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6aff3128 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8
 a=a3FyozKr4OXg-YhadtQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2OSBTYWx0ZWRfX5hKU9AMUQXG6
 Rjy/dDLFZFeasosjQbDO4Fdh5aF5XlcQvx93ACOqlpus6ZKbdGZgY0hstBR4Xt6fLLuRu9tMjWc
 pVi2SCh3B32Uja3txi7dyGOSXMa4BRA=
X-Proofpoint-ORIG-GUID: aN6qMjTUmxqAt-mKuIb1wprEufQV4ud9
X-Proofpoint-GUID: aN6qMjTUmxqAt-mKuIb1wprEufQV4ud9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01

On Thu, Nov 19, 2026 at 10:03:10AM +0100, Paolo Abeni wrote:
> On 11/17/26 02:20, Bobby Eshleman wrote:
> > On Mon, Nov 16, 2026 at 11:52:38PM +0000, netdev-bot+sinfo@kernel.org wrote:
> > > Hi!
> > > 
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > > 
> > >   - How the issue was discovered, e.g. hit in production, hit during
> > >     development, syzbot report, manual code inspection, LLM or static
> > >     analysis tool scan.
> > > 
> > >   - Whether the issue was actually triggered, or is only theoretical
> > >     (e.g. found by LLM and not proven at runtime). If it was triggered
> > >     please include the symptoms, like the stack trace or kernel messages.
> > > 
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account.
> > > 
> > > *IMPORTANT*: If you do repost (for other reasons) - please include
> > > the relevant info in the cover letter or commit messages.
> > > -- 
> > > The evaluation is done by an LLM so it may be wrong, if you think
> > > that is the case please reply and explain.
> > 
> > This is a known issue and has come up in review of the guest netns
> > series (so via code inspection).
> My reading of the above is this feels like more an improvement than a
> regression fix. As such I'll move this to net-next. Please scream out
> loudly very soon if you disagree.
> 
> /P
> 

My net-next guest ns series actually needs this to build, maybe I should
pull it back into that series?

My rationale for sending to net was that it also fixes the issue for the
already merged vhost-vsock ns support. I don't have a strong opinion
either way.

Best,
Bobby
