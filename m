Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834142;
	b=qFDDl+8uvqvF2lxAhOr8M/P6Z+bw5FKu+crRJH1K8g7w3NfsbYe3H0l8dR5sz9cR7lt1
	 +KCDk8dmWMySo/kl/g4e43Bt9OGYPtTw5qr00/fyDzOeXNsAQdtUOv2n5VgdB41IcguY2
	 FHovBbC7zknSiZNb5iWAPPQQWpVNzHqhXhxzG7k0v8SabJlfD0/jfqnBvzALY9ZjYA76w
	 /swPDrv4ouqTUT6uDLIp3SOih7pacUe5SZVp6svJIdoLbCK+EXkybMtXpEFdD8DN/9C78
	 L7NGO3Et6+4AwhF7sBW2YEqohGKUCar5lxmOFUGO32bVMmniHAqQeg2lTAMbvtS8y1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
	b=vDDpOlkaRvE02H3Iq9k0Vvko+hXUHvUgWaW9WjT1etTgR5QRTl8vMpoznUBKEaTvPRi8
	 UxGywf7zWw0e1uWLzOLvq5Uxwl1WLCBItZiOqapo+02dw6Tfapak+1+DfrD+o0Hs7kWTU
	 PTpH1jzpEfobuxrUuzpqHlOGrkiXzHVXDRyyJMCQ3oCf+nxIUDEethjNIPcXmScf8BPpe
	 393UACZtjoNxxIxp3NNZPi5a3kJatmtL1NF4x1ozVHdd1MoIumn+5b5IjJI4+7yB9yJDW
	 jgS01jfJi+YDIMq6q7efLer5HHmY/EI86TlwIlIe0duimItj+D4rjTezWSF1hv7lV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axhdwTpY;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BF606A326
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C0BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=axhdwTpY
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso13044485e9.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793834140; x=1794438940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
        b=axhdwTpYq+UaGXjhC77ce+Tg4LB7x8gBDFrWSoDcxdhuvO5tPQtPCtz9GvNylrSkux
         innhVqS5u+behTS/qXCGj9Ags0kOlTEczMI0WuGXOqk5wPX3IolkzZFfnYe90FxxR/lg
         iiWkFcVh1EaSwZX4TlasKlhH8+oF1+CbMSlrD8GiJA/x8Qxjpw9u45Y2Zcrab+LjpwOj
         aYMJCRLY3srOmcAWyeVa3xU5OJs5Vjp2TCDu9zXA6yGWbRUUnmZ+Iw3OeniD/DPGwpxb
         PLf2pLJIpnvrQd/sULK1CxhhBb7FigAFvgflcaZDFQ89Ti+/EqMK/zk0qPMEaC9HiBRm
         hpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834140; x=1794438940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
        b=oosEeslyZ1E2QVEKO1GBCr5Prt5RXdq6jCoE2TAbpvbFBBN/yusiWWbU7s+XzrG9E1
         JaNl/XAmF8XyZQmwH23UTfsAr9Adma3932tWhn8eqX64l6DrJufsGixDGlg8XCwtpcMj
         yD8T2e8RSq1cIoGq2K5zjOaEWy+sO2dgpQXr1Ac4xy3FsZjd+mLlulMdmIgrWac/2ncM
         D33B/22GWQYakBZROgYqySyjOAnyGOhORqgxHKp6vq9+XnJu4nLqLVHyRXD7pWBotEJP
         29yOI44r/djvZK6BG1f2c95VzaeT6bJaoEwTHwqpI0obyGPHk0d1PAGGZqHX3Im8OgU1
         V6pA==
X-Forwarded-Encrypted: i=1; AKwUvByuNWLg8yLrjCfPo6fSr6QQ1EZI21d2TDxKD1+9K60xrS5zRevDojXSoz3hfaEyDUeG2Eo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bK6OnjwvIxbqSqx+t5bGvpaweW/DNd9J9ZB43d+BVLyG7r2aW
	ewUHlrxPUQ+iu0+DR8MQ54uVdHVqYXYX/7Cq4l4bQvehJDtByfPbOF8m
X-Gm-Gg: AYBFou3zkYki5SqLjULLfSuRlLyXxAtgb1gYgsER+siRw7Rwp5BGUEOnpQdu+CLxlIP
	0Rj1DQE2Z37fN0NHIodcoN0j+b+UNBqUGX8CMhxo2RKBgzw6s1kiB6xQe/ZGM7Etici9142ON/S
	OqgJ0YI3NHzTp4qDinaltoRTIM/a2VCC8hcqnduwRtXlHglFt9lca73AR00txv7gKrk3zgxFdks
	7tIdRaBmKbHWbke5hZY93qP4frBVgJhmiuLk5KHJzKdYMhTZ5ox0XCn3gOhU9EzFfo9gLe+JssP
	g1mLevBbEoYEKenNFXWhnGY+OtdX6ebBTdNK1+G8lr6iOcN8uSdThOZDdZuub0ZO9ap/InzpD9v
	4kI04iCflXV091bC/WKOSyuZjhAtM+JeoU03oF5nV6t7/DSGEi5qt2LAbS4isMNcBkEyJ+LiQfC
	DXmdcXs9pmu3MTqeigaR7sN8nJX3lqcgutj5qNU1Fff7eyh9c1STPbOY8Glm+qG/GaYcf5MAjE1
	ZiVCDyoOHQN581zoVdfiP3gXzBygai3Nw+ss5kWnMuC+6qk2AlUfiH8BeW+y2VKjZAE+QMDibdd
	xmuQ+NsFjZ0a722BqcNEMRM=
X-Received: by 2002:a05:600c:3f0a:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4b3c3545341mr83410955e9.20.1793834140542;
        Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20567sm6769827f8f.51.2026.11.04.15.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Message-ID: <ad6e93c7-203e-470f-804b-fbf7ac9890f2@gmail.com>
Date: Thu, 5 Nov 2026 00:15:38 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> +	pmdsize = read_pmd_pagesize();

read_pmd_pagesize() is pmd_psize() in mm-new since 5d123bb07b18
("kselftest: mm: rename read_pmd_pagesize() to pmd_psize()"), so this
won't build there, will it?

-- 
cheers,
jose a. p-a
