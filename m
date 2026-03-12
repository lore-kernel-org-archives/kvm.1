Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8C34D389
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324258; cv=none; b=Gg+62TjYoXjkf9fgycW3i0WCILXx6ySWz9RQBmBpWXUNqgEibMSl4ZmsHXBC/zfPHDhb0DVtrvRqCFFEh3X7loPGqrf4sbO6ToaeaNSfO9x+RNkRBLclRx2eT8Dqk1cgeSnmGEa6xHsw/PkmO24V3q7aZxjbyGLtw+haSvnfv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324258; c=relaxed/simple;
	bh=BYh65tFbToyqbIgl/e+1KzP7lXIxITFsnWtb3vXm3ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUfdgOy99BGaiF1uhKbRUFG2gQOruUpuVhL2yzQVEBFAiB6ioReQWr44Hj3ZvbB8W0xpmt3dJqa5Fp7+RUtvXgKEIsEAbC9iNlw8CA5K3TuWYZEtOtuS6VoccrRnSrK94FAfJsyZbIPRl9NtBuWt30ag4id2YhK3oLOVXarvyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hs9KFJnA; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hs9KFJnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773324255; x=1804860255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxnSMd6vqotT4vip6kyAe3t5umsc9aEJiWQjl5S6dBY=;
  b=Hs9KFJnAT2bSaq+g9UuWQrXA2GiY3Af5w+4VIS+xwRZAnsBNOvx2KBQV
   EGaz4DvPgRbs400AFLEiZVjViOIMr9GVw9zSB4k9Q/I95e+0EfVpvbO36
   /292KW3KCsfW612trlURBrO+183axBjMe09rrmc+R5W/2bj0mmCgNm7iW
   VYK+8XdAUrBymByWCiGPBq1pD5SJjBczpliE0q5w+wRFZDMggy228tswr
   Oy/LbSx2TaqjjUiFXaMbN9Cp3uzKLMImzGgEXBONQ5qQz3kBm8UGFH5Z3
   4uUtVMnPn+KEGJYE6KKJsujvDUNp9tDv58HNnA45Eldy25IW96NIZX48L
   Q==;
X-CSE-ConnectionGUID: h3KrIXVYQSGtYZJDbpSWjw==
X-CSE-MsgGUID: +erQGpZRQjmL1WfbJF1FrA==
X-IronPort-AV: E=Sophos;i="6.23,116,1770595200"; 
   d="scan'208";a="14892378"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:04:10 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:13223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.3:2525] with esmtp (Farcaster)
 id df95a237-59bc-48c7-a4c5-0dc8db1e4930; Thu, 12 Mar 2026 14:04:10 +0000 (UTC)
X-Farcaster-Flow-ID: df95a237-59bc-48c7-a4c5-0dc8db1e4930
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:04:09 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:04:06 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <dwmw2@infradead.org>
CC: <david@kernel.org>, <itazur@amazon.com>, <jackmanb@google.com>,
	<kalyazin@amazon.com>, <kvm@vger.kernel.org>, <patrick.roy@campus.lmu.de>,
	<pbonzini@redhat.com>, <pdurrant@amazon.com>, <seanjc@google.com>,
	<tabba@google.com>, <vkuznets@redhat.com>, <zulinx86@gmail.com>
Subject: Re: [RFC PATCH v3 0/6] KVM: pfncache: Add guest_memfd support to
Date: Thu, 12 Mar 2026 14:02:56 +0000
Message-ID: <20260312140401.32066-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8e92da2766bc4bffd39dd9c7c1fd205fe4cee481.camel@infradead.org>
References: <8e92da2766bc4bffd39dd9c7c1fd205fe4cee481.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 11 Mar 2026 13:04:13 +0100, David Woodhouse wrote:
> On Tue, 2026-03-10 at 06:36 +0000, Takahiro Itazuri wrote:
> > [ based on v6.18 with [1] ]
> >
> > This patch series is another follow-up to RFC v1 with minor fixes of RFC
> > v2.=3DC2=3DA0 (This is still labelled RFC since its dependency [1] has =
not yet
> > been merged.)  This change was tested for guest_memfd created with
> > GUEST_MEMFD_FLAG_MMAP and GUEST_MEMFD_FLAG_NO_DIRECT_MAP in the feature
> > branch of Firecracker [2].
>=20
> This all looks good to me, thanks. I'd love to see a set of KVM
> selftests to exercise it though.

I'll try to add selftests in the next round.  Thanks for taking a look :)

