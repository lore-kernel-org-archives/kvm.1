Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874158;
	b=HDnklbVdVx+CVcC+p6vXSGQZne+gJItxD4h0G7yI2P2luAV78/2YQtyPNPIXQULPz02G
	 3XHpVJBsSNOSlISoST/ti9nYybtf94A2ehlRkHDWW8v02CWUDHLHUNZjqp1bjqgmnZ/IS
	 zAiNhfAWhEcuYpAb4Tf0Ayt+1+v3bjVNEh9dAF4HXSKcbqNR+mNsV+xTHL+iDpcNj3NOY
	 w/ar5lytjSInoZOoehSh3imPuSb6xLwgOVHHmJ8vbjC7BLhQJRsB4LN7n79uHYjdoHdNk
	 n05Nz2+EFrItO2yHwe4mqu7AzOOWEnYuha69oQ27re+fevfwhJFLXxOvYBtNGOtVQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pTrfmCeHoWlhZKSWNZnZzfNn/A6ww2uD6ITBjAv/o7s=;
	b=abtu/tQoeHC9olM3bocISrhh363Jnr2+tXKtuCl0h9dK9pMxzC9E4ACbOlcB5OWXfNZ6
	 jaxXcmn14aONnqHTg2XeK+VcUjFPijxEUFXtnNWD62SNU4LMz1mbvxcvCdS6eZ5pmyT6v
	 X6Y1IqGV0BKb98tHrUB4YJyrxW8BuAdiyWMkPPr//429+BnIsuHtC/8zTwedaQEUY3wbr
	 oXPzG173IakjeXTg+7V82RTOLkKxF6BZy9AhHHuf15RKcUV/5q/9y22CsdQb7CrdPUyH6
	 kx8+da/PnzRIMIFvVD6b9OlgBLSec1ATGEBPHn4+rg8gioISxuHx90q4GPXfCbO8lNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dntHVw1v;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CB606A323
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 00:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 635CB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dntHVw1v
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso3058521a12.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794874157; x=1795478957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTrfmCeHoWlhZKSWNZnZzfNn/A6ww2uD6ITBjAv/o7s=;
        b=dntHVw1vYt0X8rejzm8+5Fc++nZ4b0a9A3nHB5izEFRQ1xt01Lf6SpVFh5sI6SGQDq
         wYjvrawQRDLG566kS9e6TfF6DWI9JdBKxWWz436fDvYxQ1K/tlAQLdG9MuP85zuQtS5/
         m6sPxW+XgJuUdmlysOLDCAIELFhH6ksC28fMJF2ow+5OSEBjpNVx6Vv7Wi/SPLJIEG9w
         KjxKsw0YBA404XposGPpkDLhXcQNXVjH2cReHPHy5KSTi372KR4+BD4Noyi2C2p7s1qx
         ezSTdpQFQAd5Ia+yQRcfGthS2ODUaSyZ4zF5mmipFb5GMWMu/Fxd9tPLPtYR1KXlHyTN
         HnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874157; x=1795478957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTrfmCeHoWlhZKSWNZnZzfNn/A6ww2uD6ITBjAv/o7s=;
        b=T80h5Z/mHkeAn3xGmxfJZ98VlAkLutbtA64WH0JvKv4U83RFSpSMCN1nk1gSEOzGD6
         XCoxZy5mZD36X/PESxArnaUwllofWIYyxugoRqRtg393SOPKdWsfMyVL8FIeJ8sRTJo7
         AxffIQSqzthL8P9Xlh1veOoCQjEBpxsCcrKgiIp8lpa3UT0um6SQOozbq077Gc64xTno
         SaqwGHGWrGSHclxsrTFSQDF02u+70Ylo5U1vxNiYKh0/l+6FKpewwsBV/pjUKqMOReCd
         vic11V1lfmt2lkIqQ/uH5qfbaEIltimwpt15eoWVJax1qW84m4f+YSwuC1aYOVw6GGUB
         t2Rw==
X-Gm-Message-State: APuU4Z8RJbdTaTtZDzPgFoAkZ0GHOYpyn965BR2gD59DKv29b8a65YRN
	SKtCKgOor5eRKECY+Vgx/hdgeUZB2i8ob5NLlNTUYZgHxP67ChFy99dG
X-Gm-Gg: AZFdTZfpCwJoYLKG7KbVu9GT8fooM6cr4FS1THST2QFRlSIKstiMllCOa8dem5FCywg
	FfSeqiXgckWhXlRVhHvheU9w7ZtL7Ore2SEpDBfNUpgDUwTXd/e+jvNvkaTc1pF7vjwEkniNoAJ
	Podqax6HZwkiUbBXmlD5JT8tihTcGuMjPFmgcRz5KA8mTK5zhOFPNkXASuMSTIyWemwm1IrH/oY
	F2iV2F5fwDBhany+Zc8iHI4qKZhgtDVXArVPCmfkro1Zdcex7C5bFdZHOq9APQbEW/eFLmoIAe+
	9mvNiN/CSN5rMvFhz6quSdTitPniPd2W4U2hmBBFvdvX0P0S7R9G8JRwdVO68fAxtZCPz2bjUps
	wRmPAm/Q4PpTm3vLq9P4BaKG0pqeag9wfSFfuwsTCg/CdQ9GpMpEDbwNhkHYGalXncw2Iwsn7P4
	9llVWLF/ZD8V4sdsTs5JQgKXfJYWJMnUKZbOyqPFwa0yw/C8mKBwr/2bRXRz77EOoEj4HN0mAmY
	84zmF94kgMREO9JSxtOHLNUDP0k6Oa2Po83B6kGxNbHUVGWun1aTMCmLiaQ0JOaIkwBj0UEWxEd
	sTwt3tv3upukW8kX4K8EdD772zFOddyxqH8jfs21RgjpS4fX3L69+5JhtatYomJDeynfE3Q9ztG
	vs4wa9jgx+633EkBSR7Z+4PyrlxA2HpTt9SLaVgR8gUcLpKBoGk5UKsj4tQjm+NvUd1OsNMAdp6
	DnBc9k6cIWj3VJnga1HsCBjUQanPUO7hQ=
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr10684993a91.33.1794874157570;
        Mon, 16 Nov 2026 16:09:17 -0800 (PST)
Received: from cs-arch-srv04.cmpt.sfu.ca (cs-arch-srv04.cmpt.sfu.ca. [142.58.10.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b25a365asm9273069a91.1.2026.11.16.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:09:17 -0800 (PST)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ma.mandourr@gmail.com,
	pbonzini@redhat.com
Subject: Re: [PATCH v3 0/3] KVM: nVMX: Don't clobber VM-Entry instruction length on soft INTn exits
Date: Mon, 16 Nov 2026 16:09:16 -0800
Message-Id: <20261117000916.3904913-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <avuF8vW3g_o1t5DM@seanjc-mac.roam.internal>
References: <avuF8vW3g_o1t5DM@seanjc-mac.roam.internal>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 16, 2026, Sean Christopherson wrote:
> v2 still applies cleanly, there's no need to rebase.
[...]
> TL;DR: please be patient.

Understood, sorry for the noise. Plain git am failed on patch 3's context
here, and I should have tried -3 before rebasing.
