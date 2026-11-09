Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200611;
	b=FAkwNUZ4Tms6vSvOnRH0BkMjtbogUu/XoNfYyB3R+Inp5lsAUWuxscYc0ysubMNv8+2i
	 joaOptultq0749q1+aKJFosKuHXrt+ZqhLBfZDBLLH7H6tcPW19foCty/zBgYukVqgXIJ
	 Lj8ZdPuAlDDzUyfEyrATfLP2xTebJmJAFfNFd0pJr6rWzQ6w78KNNHbGs647KkoSPs676
	 V69id72bWpM39a8kH4SBuoVVVd7oSPiiwESGOqS9Y0p5Hq9toTpRi9cp/F6TT794ry17D
	 bo+Lm0DR7oeS8TmegogO7tVEX+gS+OnnGKUPCgYEbXCR0xPvn75rJnp6fPhpq81tuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200611;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=WKDYdtIPpXv/RzXHp6m0fnJtTmWjQH/piwGs13om7po=;
	b=i6DTyae+ZCpmfGzCGchOR5MeqPb2cTjv6nsF+B75NSOMyWIw7Rb2OF6OLJaUq01CCaN6
	 zo+tQ65KCjVKL1jJ+RAH9sCVmdK8wRRiZ4olfsVW4YwA7wyi0VnKVup6tCqtDmP6mxRzy
	 PQMwIIiF3jTx+W8b1wWk9w41j26X0sG4XsJkD12tZdlDcVTuEpUvzF5ykYNpHDxmPG/3u
	 7D14x4uaQH+6EV7ohgmmrbbpxLQSKvZg+WlDraODRmq+6fKWpsQciVRh/vlw6ONGRmSvM
	 tKV8SME2Qdx7PNeR0h4Fcfatu7D7mTrZgDWlvIfFciR5ois6bc+jAjsHuKWgOaNFAiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD03ukNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EC606A31C;
	Mon,  9 Nov 2026 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD03ukNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4746B1F0089F;
	Mon,  9 Nov 2026 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794200611;
	bh=WKDYdtIPpXv/RzXHp6m0fnJtTmWjQH/piwGs13om7po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GD03ukNX3qpJy/ulw8mljNcuZ+ffE/s+zMEiPrDEJKEQ+cye+2q2ws/q05r9C/MwA
	 8lK5saBohFqhyS1SyDBT7NAkEwD8aM3vrlD9P4LPvGRgDSSGrGefVUdGFsWkIN+fho
	 KpZxXNBbAQhXwg6sB5B8D8Vm59TczWTrD2qm7awrv0ZfpqU3B5VLjxjl7H1AjqQp4S
	 i75YS8Qrd7Vyem4PeyW90tc16A0bzx+XMbNpRh3pm5DhqNFrGg/rEHLk/84mg3sQqd
	 qGoOtS7woGspYXn7FCWWhnpfaGDKLNbR/J6K7jjxa7wcob9PfNJ6OsgEBIyHaJT/Ms
	 gyMazdqf0pplA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jianxiong Gao <jxgao@google.com>,
	John Starks <John.Starks@microsoft.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH RFC v3 64/88] vfio: Add vfio_device_gmem_revoke helper
 for guest_memfd
In-Reply-To: <20261106-gmem-alternative-providers-v3-64-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-64-8484dde66a7e@google.com>
Date: Mon, 09 Nov 2026 10:33:20 +0530
Message-ID: <yq5av766tx47.fsf@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> When physical device regions backing guest_memfd memory must be revoked
> due to hardware reset, power state transitions, or memory decode state
> changes, the bus driver must revoke and reclaim the memory ranges from
> guest_memfd before modifying hardware state.
>

Should we prevent such operations while the VFIO fd is attached to
guest_memfd? Some of these operations can transition the device to the
TDISP error state, and we should avoid host operations that can result
in vfio_pci_zap_bars().

-aneesh

