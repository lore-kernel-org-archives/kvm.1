Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330231;
	b=rPZqK576Gz4bExgucv+NS9kC9hOXwFZ+r5TiV+D4xl1eH3KV9PWPUwFRPl2iJdgrcAC0
	 4OzaOcFcGp4AZ3DTstyd1H2iJcn2HWPBKQJvO2sv1pXA6v+Z4qsM87ru+mu7N01LRO3JA
	 cdC8T9KCU/77374ELR6fRyEr+zZVudNAOaBSE7DvQHeJQzt31dU3p++43C/4lhg9PkWwi
	 fANczueWrQku7Ul/CGosG7EgYM7c2TU3Kxubgt0qYCuFugF+kfuQ6J+Pg6jOp3DgJiU7d
	 YnYWo7XJ44SXLYBqiu1Ghov2yhZV4s7U2MxOoFVU9h2XFC4cDmiy/vCExel1kchWX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
	b=ShQJ+NDIPAiSzt+5Cvgp94uYwaZpVmF/JOKgURgyjcDLTE2U2bn+Ww9Opd0zhgLpgGlO
	 Du1tyzdiqCDCD2dxBAerNTEXLF0RWLVh+cJiEkwV/kImSri5NqfeVb2sxa2G6dTVopmYU
	 sUgHKC6u7Sct7vupbmxVX/Bw63cqsXc+bW44GMiZV5U89T3nt6/OX7Z+kWDGwQLK4JNYQ
	 XM0wmeVe6uddDVf3x3uC9Tctk4zjg614pf2tdALHpItVYKqYSKLiwo9Dwk9eC2jcvuTNX
	 v+pL5ue9GPq/GVqsbB6dAs0pbzoJ0pNnpRp/fwLRB5qbGRf+8j+M5ECpNETY0ZhFrQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DD606A323
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E1DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1148881a12.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330231; x=1794935031; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=CqqEuFk0AQlgr0+Pai0aviiooV27t9niWrHV+H8eRhc+6PHDFeXh1X96vJxa/Dt36f
         f5Yiz3snbFS8BnY1j43shKrs+nTnOuO5TOpWAK7YB+Leh5xsUkN2q5DbPCq8EWLyDMiy
         SzPOWc1tlmmFvklAq6qlbkiOasGwfDLouqOFbi0kweOwsAx2q/xRkmpeKCHL1pjwIiGj
         wwWVGLFDXcV06SGp6Uhov/nBULclJ3h1Qlve99omyE4gY7ugTdgLPim71rZ86HGq12iZ
         6lYJrUjctnrF2QxlZ+pOeh5J+gK8+JpQT7MfqqujhOFhX/ZmgaHszxt7/F3aM+6Ikrlq
         SbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330231; x=1794935031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=KfS2ddlPiQvQFSqM5lu5vvBl91V7wxJ94csYGdVB2An84QzknV/Hbe+s5N38IZUoDq
         ZKJv1c5ZGEiQ3FAoy4WgJginsNLKVBk3uGpOtqy9KXGl0UG+zQ/Rd8ZSoZ5v4SJIChd1
         qRJ0OpmThwpSg8E8yHcoiqoUZrI10f5S1kyy2nJdPWwJYmHmR1WxZrdq37K7vzlsucuF
         b9P6WWUGVMLjtPMrv7NmrPNyjpcfZ9xe2Nfmh8zejuS1+NW/ZXd7a6ZHV9HACvfn0CJw
         WbKpevadSWxSUnuqLStDbHv8leO8DlKWmYpVx9Zv8IzDn0fkFx4UkwghoIMiljhZHWT2
         i4BQ==
X-Forwarded-Encrypted: i=1; AL+hErEqh6z5ETB4daKoc5rB47vL7kLnZRFng7AYRaWPWWyi/0T8qQhnSSgXEPyLIKeCqTFVhT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B28RYJHXj6Jf1+7JBWuvd/TdElV4AGgdjbcNJ1uMBsCbd8vtQ
	9OTx9+xsbC6f5IarmhimSz6SChYfsIxG1sO/FLr/tf93kgG3VRu3cb3kRAjDG6G6nQ==
X-Gm-Gg: AYBFou3pBWmHtiLC6Y8PeBMnQ7XqDPgB+x3Hn7lTdYggrktniHwOQLusIDNNbe80hSW
	HTTuwEv7tEUNn0GWRPc82V+qaekOSequXuQOKoNPNE/XBwts3lAfYBtOOOq0O+bwp88Eu9ZiJ3n
	tv4aZb/ISbX1gYtYIMEoxOGcxGz7iUI+xJscms1VkZ6V3Pn971BBiLabEnqPcw7PjFTp7281XFV
	L7cL0Xl6P3Q520quyoeGyxqRcoiXKSSAZEPtvAeUTIodkuTjnekLQtWdObuNFIKMfUpJ8cZ17we
	1sta5qF73Tb//r44yESXucUZJUNCWkZuXXMXMo4P9BsFdgXFj4rtZ010nOAK5rLO2Xy3XEFWtQg
	SDEfoZBIKOlalWyv0QcjXkidbP6zE2j8Nhd77kW1v/ng4MJk6er64xHGCW2BsdIpKPjqx0lAlLH
	b+SSAyC/Uv2BVcn0uM71t7xv0+GdaLhhPFr0tX8JjYehdKsexmpFe36sRQ7eNWYXSxIKObbietw
	e1lBcknmD9YhAPUXv9Y1ByXZ/RcgckmZ8bb934OWnjjietdHBuh6jyb20/ph9ifZNH097bnqMXc
	VgPtyW17aIMarab+XCPMZdjdSlz4nh5R3CvtRUT4ceO/skjFSrqOBxdpFuV+7NmI
X-Received: by 2002:a17:90b:524d:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b166cc14bamr3213232a91.15.1794330230055;
        Tue, 10 Nov 2026 09:03:50 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm514293a91.14.2026.11.10.09.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:03:48 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:03:48 +0000
Message-Id: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,

Since the entry size now comes from the block headers, incoming block
sets should not take an entry size at all. I pointed this out on the
PCI patch (16/19) as well. As is, every incoming path still calls
kho_block_set_init() with this kernel's (outgoing) entry size, which
kho_block_set_restore() then silently overwrites. That makes the
callers (e.g. pci_flb_retrieve() and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size. kho_block_set_restore() should initialize the block set itself
from the incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

Please also add an accessor for the entry size, e.g.
kho_block_set_entry_size(). Users of the block set need it to check that
incoming entries are large enough for the fields they read, and that
the fields of a feature are within the entry.

[...]

> + * Each block header also records the size of its entries. A newer kerne=
l may
> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.

KHO blocks can't guarantee the last part. The iterator returns a void *
that the caller casts to its own struct, so it is up to the caller to
not read fields beyond the entry size. Please document that callers must
check the entry size before accessing fields that may not be present.

