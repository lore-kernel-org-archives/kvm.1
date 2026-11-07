Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011834;
	b=IexF1zJAVyje30kD1t6XqOJADTU/CbXRz0V1RHu7EWhusKrgUKB8zortnWRfius/1RJ4
	 egdScwi1mCMSB0cws4KHz+VdUuwtgtg0pKXuyWlksiJc9z1PfmckNnYm15N9BTj+z0vR6
	 c4hAtIIUmfOWZNz8Njwt0tLXHCWvOoquwE9kmJrFt5ro4pnl5D8EMuYTs5IJCdFsPOQrf
	 LoAWmKg4QZCR5+xHv2BLr90O6p57EnrOAD6PVZnAiPO3FpxZcPV2CqRp5APz0LYzXIf/+
	 mwyb3ngsbaqyFF+7Jn/BsAem3O0zjrzcw0OlM10cRbzYs9uKWi0pctcQLv2LjiHlgtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011834;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ttx/3hBeE8lksy2FGsNe5d3QOJT7B6jPkU8kfvGYtR0=;
	b=gID4rUGrOjYOKZF8UeBS0VTPUqCT/PO4A57tS2GEbfTjAEjqKXx4F/ffeFt4CpXmFj3C
	 VvSablX8PDTc6/BAzDp7f6SzIyVjxIlDG60Un6X2QcRYgjFfVFyQaGkZBeVdpPvIAQWcW
	 iE9yZ8CmiemlO/5RoWur+0dM7g7Rc8bpIPcpZIGZDB4StjfABdnI6LNbufqnGEnw3uR+5
	 dri5aUX85egag4v/eENnyWTlAMT6iFlRs40hltCvAPwkn5ZXrOJzsg8pOEtc0PJq9wr56
	 ZfUoRP0aVCfJxv0CMMWP7CI1rlSHXuOS8dxJULrsIVjkuLFVeGBSyDZrNpXGQrpv2yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHW04eun;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A460A5BE7;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHW04eun
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011833;
	b=iXhcGqspd84qIcGG4hgIzBzwygszoI5mxwNS1oOQUoXjwnM4P8kiK2AVaYyE6rF06umQ
	 i4S2f4A0Vapa4+6XfANaiOVjUBLkUD4eE3CNf8zovYu9zWsbw4x/WGJfvgivYIez8MqSp
	 6orFbrK4VZkeV8LEVOu2o04S9bnN/locc2K/fZUxLj0zh5jr49ZvolefYBgZE69oTOa+U
	 H3CGe7gP9ozwpj2Z94A3ShbJ8r5YA0SkZwctW5kPvAQY0c8Jc2Sa5IOSUX6XeSaGxueaC
	 Q9x+IgYeYRe8G2LE19gM+e8ww411n3NriiSzCyko0I3TISFjFEQTIWoOwOjL7hKvIhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ttx/3hBeE8lksy2FGsNe5d3QOJT7B6jPkU8kfvGYtR0=;
	b=YwiOYJovE4HtCnqYs1KPCtjrvIC3xuAE8Z2jqSRtAP8VNlfZq5JaZ6HJbAMWvi4qdC4r
	 FG97H9QTU4ieLSZFrf5+emrWtzZMzMiSKJ9SfNvK+V3kYfr+sUL1p6702CqfS4OqJgWUM
	 fnAvBYeMwpSYqQbTPlAHXNDi8JPpYQd7iNI5cLl+qPEoJvjHyTRK8pV2zpbQbyxnlNOEk
	 S/qIL0sHbGGPIVM8055XYN3AZeV76yo7Qq8ndTO2AZsbA3lU8sXQz+QCXGVG4/8D8bR+9
	 v6t/5ZN9DSsViY32mHO/w0zBvMw/Pgtk3GRp+VX/88b12iVQlgvzptDRj9yPaOvnr1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A36551F00AD6;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011833;
	bh=ttx/3hBeE8lksy2FGsNe5d3QOJT7B6jPkU8kfvGYtR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HHW04eunuqjPqIEBmg4cgYT2MQ3D4nbkYA3KPz/7EfS3w3mRbMwseGnvbghUSl5b2
	 9AR+rDgTqI6lJpJ4YZJ0o24wMvvM+qEzJhYoMCwdGBGa7SI295+sBYu4fgmplG/YKg
	 s0EFKc3J8OsBUAi8HfDQUlXFQDPIKcQpGJiV7gD9Vnf5GX2G8U0QEajQVP20z3Aq/s
	 CK8OhTsMz5h4KQ9NjWzIiMXVhn/iOrC7iv2ZZ+aQzQg6krCGMY3jSvi01efeyqm+Ha
	 Er1gj/KySXQrhGTAJR3u7n67MxEx7oTgN6yQIVPofV7I6HPlnwmVOcl5rGSdYpc5c2
	 kBYaL65tIpehw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 069AA479C4;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:19 -0800
Subject: [PATCH RFC v3 45/88] samples/kvm: Disallow MP_SET_READONLY after
 attach
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-45-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=1622;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=W6hpgZ/SuWeulozFQ+D1CrfcagL7NIynEtQGb/opNZw=;
 b=ILyPeR8Z4qzwmTsH228I3CTu1pFhQQ5MWMIByYFJpNmOGFiP/sRffFefkPZJvJJmQLFRCWCMe
 r5kLMeQnZa7CLlcRG/TOCMgsnzmWL3Yhl8aE192+9z9TDbTji6SwO+6
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Once a provider file is attached to guest_memfd, its physical attributes
must remain constant throughout its lifetime.

Disallow changing page read-only state via MP_SET_READONLY if the provider
file is currently attached to a guest_memfd inode, returning -EBUSY.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/memory_provider.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 6f86e3e3262e3..168c1d90edacd 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -58,17 +58,23 @@ static int mp_range(struct mp_info *info, u64 offset, u64 len,
 	return 0;
 }
 
-static void mp_set_readonly(struct mp_info *info, unsigned long start,
+static int mp_set_readonly(struct mp_info *info, unsigned long start,
 			    unsigned long end, bool readonly)
 {
 	mutex_lock(&info->lock);
 
+	if (info->gmem_inode) {
+		mutex_unlock(&info->lock);
+		return -EBUSY;
+	}
+
 	if (readonly)
 		bitmap_set(info->readonly, start, end - start);
 	else
 		bitmap_clear(info->readonly, start, end - start);
 
 	mutex_unlock(&info->lock);
+	return 0;
 }
 
 static void mp_set_present(struct mp_info *info, unsigned long start,
@@ -123,7 +129,7 @@ static long mp_file_set_readonly(struct mp_info *info, void __user *uarg)
 
 	ret = mp_range(info, sr.offset, sr.len, &start, &end);
 	if (!ret)
-		mp_set_readonly(info, start, end, sr.value);
+		ret = mp_set_readonly(info, start, end, sr.value);
 
 	return ret;
 }

-- 
2.56.0.455.g6c5a503b38-goog


