Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823033;
	b=KxRAhL8uuhlkogkZiHBZZzPiyebP49+xvmltgFldlbugk5p0UB0TpXBOWdHDsuGGtX74
	 ltPQQt04rpnSOkFqyabBClBhfjfqNCKQNcPOQEFkFXuiahF+mHY6If5p50XuvWxEtMk3y
	 Nm1UITmvRqiwTHPYY0n4n92gbCy27F+DF5x3yeZRaz5gS2DE3QcqZ1PYZ5K3w3cG1gQwS
	 CjN5vPv/5IWnsgASSCeulfnJZ6rc2L3F2i0JSNnesWvp6FHy3+Qjye56IQ08qR/b2Oxy7
	 EHCWp6VsZRGBhxrf8oPyPQAAmfgZ+ADx7u9ETkYy/EDcHUk+ub5O+VAv7XyDuAh07xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823033;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=I3+Y3topNYRnSbwR28B8ZoCVuIdcjYVT77tTzbCq1BY=;
	b=eB6lCpNKK+VkWMhmgyKMdisuE7+K5BLfUFnpQEFa3SLXqlOywHvYNG1TqPE8ssydH43Z
	 NZmrbZuVu/M6rZOUhasTITUve4Kc53f6S84M8qhS/OK3XlKgGTAQLCv6VSKHBcoU5+zUz
	 j6dT3Avn/2qeoQNc2ppVHNVk38NQb9E8sj8Bz7HBf3qsLCkWym3sg1tIg6vD1ayv/667L
	 VP5znuPL5cXVdh9ig0944BPT0GPi0gid/ciF9VA4z6JA+uYZIbmsk2wGcpNnUOzuFFwqj
	 JojBfsNS/BvjNqlX91Vz9J6D5stkGq5T438zIBeGHsGXp+dy9r3JHzPvpPNmCuw1iaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mIEa8V8B;
	arc=none smtp.remote-ip=95.215.58.253
Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F3606A330
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 09:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722F3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mIEa8V8B
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0M/7xDonC715x6+9O5Xr/LSHzL87I9czc2uSQmfZOqY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794823030; v=1; x=1795427830;
 b=mIEa8V8BULDEnZwbMezqqzI07KCN0zKeDZXL4FJMoz7e3dR22Bme/utuM2G1t+HUt4xs5PtE
 rMZtx5sS9s7IkhGSfQsU6wHOjg2m1tNUVTBCjyJAo5sgn+DQM+SJMdA9yV5L9Nt7sx7mrqOtaCM
 Z1FdH4W/U2kesabiU/A1A+cU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c88aeca00d27c8d3;
	Mon, 16 Nov 2026 09:57:10 +0000
X-Mizu-Trace-ID: c88aeca00d27c8d3
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso6398e87.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 01:57:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHeJM0DPOL9SWWruzCIWNpvoI3nU+MV4q/ag94CV5Ey+akzzG5s9KxIgBMylyg2FHdEt0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9peXwouqD1BRGrBREfWhekvW53JL4fE5VvAjTCTcVcaa0MQlVn
	1j48o1Xj8pSUDrt1NXIA/aM1HoeHTgDMf+nSNbfMdWgF+K35qzJUhMtYt0+hr4DQ39gta2XB2x3
	qKduANulOp+2t5WAhN/9BJ04KAxj5EdF3zrilj8qj
X-Received: by 2002:a05:6512:1244:b0:5c1:4bd2:df42 with SMTP id
 2adb3069b0e04-5c17e452300mr150202e87.12.1794823025609; Mon, 16 Nov 2026
 01:57:05 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-2-fuad.tabba@linux.dev> <f2f36f67-a993-735e-39d3-70e22ce6c87f@huawei.com>
In-Reply-To: <f2f36f67-a993-735e-39d3-70e22ce6c87f@huawei.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 09:56:29 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzVCi6y7FJPjnaY=xR1c+EEMTk=uSU5M2=jiXrMpoEhag@mail.gmail.com>
X-Gm-Features: Aa3M54oK9gpHPc0L5YRcoRoBDe4bteAeLTEBUq9FrNTkoJZSiv4ya5-nPjY7kqk
Message-ID: <CA+EHjTzVCi6y7FJPjnaY=xR1c+EEMTk=uSU5M2=jiXrMpoEhag@mail.gmail.com>
Subject: Re: [PATCH 1/7] Documentation: KVM: Fix references to non-existent identifiers
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 09:32, Zenghui Yu <yuzenghui@huawei.com> wrote:
[...]> >    * ``KVM_STATS_TYPE_LINEAR_HIST``
> >      The statistic is reported as a linear histogram. The number of
> >      buckets is specified by the ``size`` field. The size of buckets is specified
> > -    by the ``hist_param`` field. The range of the Nth bucket (1 <= N < ``size``)
> > -    is [``hist_param``*(N-1), ``hist_param``*N), while the range of the last
> > -    bucket is [``hist_param``*(``size``-1), +INF). (+INF means positive infinity
> > -    value.)
> > +    by the ``bucket_size`` field. The range of the Nth bucket
> > +    (1 <= N < ``size``) is [``bucket_size``*(N-1), ``bucket_size``*N), while
> > +    the range of the last bucket is [``bucket_size``*(``size``-1), +INF).
> > +    (+INF means positive infinity value.)
>
> Could we fix the broken reST while we're at it? I mean

Will do in v2.

Thanks,
/fuad
