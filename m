Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA14414
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867257; cv=none; b=bB1QV9dUFsDEj57Y1yBgTRr+JAq9fs3Mzk8RKiiPFQKJOPuZy4q898Xz80L5bnO8XXK35elyEjJfhDlBtOqrMZzmtW5IKkknwtIpAdlmqIIKxnZVlk8GnCLDfMtN0aCU1BHZGbo0bOttTTcpsxP1PbTHHMd4H4epyzv5tP8xKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867257; c=relaxed/simple;
	bh=Lf1TLdGVOJXUigkA8oRYy3fs6i47dPPa9PnAZKcPDvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j51Gj9QRyPX1zRU2BiLR/vVIth50T3DcdnXkrhxnmLFAovMy9+jvfkMzxpELudcpj9OLs+Y1oruBgmqXq39bhy5TMoF89eC9krlGTMmeohRgwVu5RJ9Nz+KmVjOCc8jJjyde7TgyZsIc50MEj9tenh86zx55Nzq8JMAQYFGwHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U9qSrFnV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U9qSrFnV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8314569eec.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 21:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777867255; x=1778472055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGXGWwnAcL1bVeuWF2vhaOhBAT20XCLM8BlTLJN4/sY=;
        b=U9qSrFnVoccKMTjlDHx76YtRO6qRyNjwxgX0cRaeLIDbSl3LBzQi4z6DER85g53COG
         Y8/lCwp77dpNf+jP/QOwqDVay6iFRt/XZu5UJc6zrSbTvwLvdEhcNfkXseWYRL1YM6v2
         C+qe4lXnknWpulPoI6om2ULo7brSESYUG/h8kfkk9KSBe8zTSta9D3/QIwWItiYfLUBA
         xys530NJJjJL8Psj3un16krJraM3phsF3PLDhch6wM/npPpGBmgUMAZvYLSsIWvXSCHZ
         wO4HR4YFqrjy0s9dRiFAcIZUEDPGIjs0i7df0iI0kUSPtH4uIp/7rQFzLCZ/dY565r44
         BOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777867255; x=1778472055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGXGWwnAcL1bVeuWF2vhaOhBAT20XCLM8BlTLJN4/sY=;
        b=dTwgT9jItvbZUH0qDnMeDu+JXpx5Jpn6oMZr1bwm/nXZkuPuC8pNakXB64UzCE45YY
         Ml7ROB9unRiTyUrFtIeA10SZduDuDcLdDuTRvig1h9RmbKSNdO+5Hh7bY6Hr7oi9vuH/
         6bLK8hepic5bel9XHu8WaC5mggJjvVbFcxkPkpNLUmCSRUt91YkqAuKuUUT8nq04npsC
         fG8Yk7CCK5+b+YLYRyKbGuN5wnLcAOKae1xm9pGqCowfEw8x/5Vi8RdhmDXu8QJzg9lq
         Wt684pvj1xIGvBZPGgrBNlWBE2DX7aq7dZzC8pncPZbmHWpiqEFWtZGlYQU2y8O7zBse
         vvig==
X-Gm-Message-State: AOJu0YyJStNiSCWglh6PlQ26V3Ox53j7nb9mMH1Jr56k3h8JNZNRzYzm
	z4XDwHmadb5jU31Bb8Gjdf1vnMOm7YINR42D5sHmMzrn0N9cOda6jT3lMzG0TMhspXfvkV4bYIA
	Z/JJ2VZs=
X-Gm-Gg: AeBDievVY/VaeIAIF2b+Wx4eOFa55nu3/lZiXXThYP7Tgg4RSqR+J1Z2F8aB9JWIs2M
	R54GH6J1bZd75FYT+iR1952L7DKz3N/wLctAQld2Rr00krl5Mis/FoOcIMrVSkIBl4Xh6oEqRv+
	dId6MHw0VIC/jS7CgVX9V+AUD8LXrVmgKuaV0ZkFbdBhzv7p7bzbin46aJOWg0BzHmLuZp+yVDT
	ygKr0FZS3x0D6XD6Ohbs7JEbESfZyGxkKNxraq8aM5EhmZNiPDpfh3KW8aFTZyPwOQK8jn8x5Rr
	C8reA6nTDjknFQP/5aFZ0jHWN5K0keCLoLPx4Gz4DoUOAhYnwm90LS7qXzTbO6QK1tA6HNZ8tEf
	t78gt9c0tLVvzaXk7IGtqXVmoZj9talJNnVpYlQ9XyOt0zkOXllbN+uAMPzgnvBMp09MWhwarPq
	HjV1IbruaDiLXZgCrYV46vrMpgHN8A56+swXKFGnlhFZLR9YvYK7Jrrw==
X-Received: by 2002:a05:7301:2c88:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2efba28ad29mr3924066eec.28.1777867255328;
        Sun, 03 May 2026 21:00:55 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f28f7ba26dsm2234848eec.10.2026.05.03.21.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:00:54 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Sun, 03 May 2026 21:00:53 -0700
Subject: [PATCH] KVM: riscv: selftests: add check_supported_reg() into
 get-reg-list test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-kvm-get_reg_list-v1-1-c16f9b572e9f@sifive.com>
X-B4-Tracking: v=1; b=H4sIAPQZ+GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNj3eyyXN301JL4otT0+JzM4hJdgyQDE8NEI/O0JCNjJaC2gqLUtMw
 KsJHRsRB+cWlSVmpyCcgcpdpaAG7UtOd0AAAA
X-Change-ID: 20260503-kvm-get_reg_list-0b041a27fb23
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, zong.li@sifive.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777867254; l=1079;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=Lf1TLdGVOJXUigkA8oRYy3fs6i47dPPa9PnAZKcPDvI=;
 b=7nvgTYMW+T1cvFZRFfiH/KnS/HC7BuQ8+FdcPWt561AW6wqKNZmoD7aVpWGYlNINN8J9EnBDm
 jS8diatltGDC0HtBVXq0RWanmKSTkPsmK9C0EPxYHOS5VJ6GKCdC5Xp
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Not all the registers in a sublist are supported on a platform, e.g. the
SUBLIST_SBI_FWFT list. Add the check_supported_reg() to remove the false
alarm of missing registers.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8d6b951434eb..d7cb9b5d37df 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -28,6 +28,18 @@ enum {
 
 static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
 
+bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
+{
+	int ret;
+	u64 data;
+
+	ret = __vcpu_get_reg(vcpu, reg, &data);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
 bool filter_reg(__u64 reg)
 {
 	switch (reg & ~REG_MASK) {

---
base-commit: ddbf9c76c4020bf63a0799b00faad40caa3de6c2
change-id: 20260503-kvm-get_reg_list-0b041a27fb23

