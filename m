Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387296;
	b=nZ6EHrs6xxycTlwIONE8Vs/QziWH75RFpmiteP9tKUsS2KiUaTXXsnUMQPIzmBcCIQAm
	 Ig9DtG+qJgFoobUCzw3Zsrp6hNtijFid8T03+6C1k2Ay27fH0uDcoGxBnUjs3S2/PrVs4
	 XM+K3JIDPT76AKkiuUQsHZwaYPMS+qMzL918CJvY3fwQZ2nTugGoc0oeXnQiPbWK197gy
	 V3it0EcrjaX3TzQVitFWJ1Nn3xkDmnPSaaUupid6TtIXvNmUGPIYGmBh6Elqz9F+3WLnO
	 MK878G7wcH3JwkDZFCY4TEnuX6JSmMwN7iu8+cBPvbBgT0GfSLg6QsFpaMTMV0fPMbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387296;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CrFXQqZImTyTdzq1JyhUooge2du6VO16INEiE6z0KsU=;
	b=wWm5sanzOTAqsTf3CpWV7qZSPUTWWFcXrWV+XIb2I6LFj0+mKcfaaAc+mviTV1ClIxy0
	 TmSG7vU2XD9IrDCjwlOL1hMmh5JaJfnan2Zn/76aMq2ke549oKu1z3Xs8tTYNgQunlO5+
	 XjVDmL7jwJkbn8pulHG36Z+5gkGlH+ivYCKOORaJn3w+KzdygXas81tdJie50IKl3A11t
	 Yk8BU1oOHgHm/OZAmKzrti1Tpn29gbsqrKAxgeHXmfqcc8B6j97MI4/SO7Ssp9v2fp3hU
	 VmL2QtK3hHEGSSSQStKtD2ukEvQKw8uYyQVllBSYAgK5taN7jj+AcPHRMZAYhsfcz2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qNIPEw56;
	arc=none smtp.remote-ip=91.218.175.48
Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300960A380B
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B300960A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qNIPEw56
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tM7HGf7cYZfxl1BGl3iBn5UcJ++Tp8B1iBd0ZTTM0rA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794387292; v=1; x=1794992092;
 b=qNIPEw56+d6OKOBKXwSZQuG7WVFvUGvPCxS2MZ6Q6ts7SSAkSYn8hQv0PPackJcEUvyev9Eu
 4XPcRQJsrp1Arcqw6RU5M5AT5KCQZjsd/0FBEmoWDzpDCYQ+zbpEBBbwifl0W3fmCj+4KhumHBL
 dn6N1Atd6CSreucZtC1iOtaA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c236bbaf59a3afe3;
	Wed, 11 Nov 2026 08:54:52 +0000
X-Mizu-Trace-ID: c236bbaf59a3afe3
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mips@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 4/7] Documentation: KVM: Drop the stale number of vCPU request flags
Date: Wed, 11 Nov 2026 08:54:45 +0000
Message-ID: <20261111085448.1130701-5-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111085448.1130701-1-fuad.tabba@linux.dev>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
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

vcpu-requests.rst states that only two request flags are defined, but
KVM_REQUEST_NO_ACTION is a third. Drop the number.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/vcpu-requests.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/vcpu-requests.rst b/Documentation/virt/kvm/vcpu-requests.rst
index 06718b9bc9597..eedf338d47d6a 100644
--- a/Documentation/virt/kvm/vcpu-requests.rst
+++ b/Documentation/virt/kvm/vcpu-requests.rst
@@ -141,8 +141,7 @@ KVM_REQUEST_MASK
 
 VCPU requests should be masked by KVM_REQUEST_MASK before using them with
 bitops.  This is because only the lower 8 bits are used to represent the
-request's number.  The upper bits are used as flags.  Currently only two
-flags are defined.
+request's number.  The upper bits are used as flags.
 
 VCPU Request Flags
 ------------------
-- 
2.47.3

