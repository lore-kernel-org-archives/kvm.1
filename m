Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D93D565F;
	Tue, 23 Jun 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216875; cv=none; b=nmwk1KLS7Y/v6zynVDo18E5gyLv0vGEvX7tw2B02vfjtEArdvtEfY19q3MhKDrVSgwWhsgaLCG5y3JR7jiixdfNMUhq+TPiHW/yC9hBrpAubsoxCGiSA/PkzGvWB5xMBR558nAOv/kNrvU6R64mK1v44VpT219ggtNzk9R/O2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216875; c=relaxed/simple;
	bh=DATrXGhmxHX4X9f2BUhFBcMnmBgTPUfyJcWtrFJwzuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7IbgqIkcFw2duyIa0OUlX/tBYJSz5qz0QTCCd5lcK39TywUhIEVy9BWDYnbxFV53wF6EABlr/oJho2hTj9N7hWBuu2YmtkMPN6KR3Se949P/B8mO9qR3tqBmxHMJUrJ79eeznW69nH7PnvkrNbz+hDNhe8eTpvNQc/G/mvNbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gl3sH1ZlWz8XrrZ;
	Tue, 23 Jun 2026 20:14:27 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 65NCEGBU041686;
	Tue, 23 Jun 2026 20:14:16 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 23 Jun 2026 20:14:19 +0800
X-Zmail-TransId: 3e816a3a789a006-046cd
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v3 4/5] RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
Date: Tue, 23 Jun 2026 20:13:12 +0800
Message-ID: <20260623121332.78514-5-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
References: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 65NCEGBU041686
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 23 Jun 2026 20:14:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3A78A3.000/4gl3sH1ZlWz8XrrZ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

U3BsaXQgaHVnZSBwYWdlcyBvbiB0aGUgcmFuZ2Ugc3BlY2lmaWVkIHVzaW5nIEtWTV9DTEVBUl9E
SVJUWV9MT0cuDQpBbmQgZG8gbm90IHNwbGl0IHdoZW4gZW5hYmxpbmcgZGlydHkgbG9nZ2luZyBp
Zg0KS1ZNX0RJUlRZX0xPR19JTklUSUFMTFlfU0VUIGlzIHNldC4NCg0KU2lnbmVkLW9mZi1ieTog
V2FuZyBZZWNoYW8gPHdhbmcueWVjaGFvMjU1QHp0ZS5jb20uY24+DQpSZXZpZXdlZC1ieTogQW51
cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCi0tLQ0KIGFyY2gvcmlzY3Yva3ZtL21tdS5j
IHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2t2bS9tbXUuYyBiL2FyY2gvcmlzY3Yva3ZtL21tdS5jDQppbmRleCA1NzBj
MDM3MWI4NWU4Li41YjkyYjI1NmFlMjJjIDEwMDY0NA0KLS0tIGEvYXJjaC9yaXNjdi9rdm0vbW11
LmMNCisrKyBiL2FyY2gvcmlzY3Yva3ZtL21tdS5jDQpAQCAtMTY0LDYgKzE2NCw5IEBAIHZvaWQg
a3ZtX2FyY2hfbW11X2VuYWJsZV9sb2dfZGlydHlfcHRfbWFza2VkKHN0cnVjdCBrdm0gKmt2bSwN
CiAJa3ZtX3Jpc2N2X2dzdGFnZV9pbml0KCZnc3RhZ2UsIGt2bSk7DQogDQogCWt2bV9yaXNjdl9n
c3RhZ2Vfd3BfcmFuZ2UoJmdzdGFnZSwgc3RhcnQsIGVuZCk7DQorDQorCWlmIChrdm1fZGlydHlf
bG9nX21hbnVhbF9wcm90ZWN0X2FuZF9pbml0X3NldChrdm0pKQ0KKwkJbW11X3NwbGl0X2h1Z2Vf
cGFnZXMoJmdzdGFnZSwgc3RhcnQsIGVuZCk7DQogfQ0KIA0KIHZvaWQga3ZtX2FyY2hfc3luY19k
aXJ0eV9sb2coc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICptZW1zbG90
KQ0KLS0gDQoyLjQzLjU=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

U3BsaXQmbmJzcDtodWdlJm5ic3A7cGFnZXMmbmJzcDtvbiZuYnNwO3RoZSZuYnNwO3JhbmdlJm5i
c3A7c3BlY2lmaWVkJm5ic3A7dXNpbmcmbmJzcDtLVk1fQ0xFQVJfRElSVFlfTE9HLjxiciAvPkFu
ZCZuYnNwO2RvJm5ic3A7bm90Jm5ic3A7c3BsaXQmbmJzcDt3aGVuJm5ic3A7ZW5hYmxpbmcmbmJz
cDtkaXJ0eSZuYnNwO2xvZ2dpbmcmbmJzcDtpZjxiciAvPktWTV9ESVJUWV9MT0dfSU5JVElBTExZ
X1NFVCZuYnNwO2lzJm5ic3A7c2V0LjxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO1dh
bmcmbmJzcDtZZWNoYW8mbmJzcDsmbHQ7d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbiZndDsNPGJy
IC8+UmV2aWV3ZWQtYnk6Jm5ic3A7QW51cCZuYnNwO1BhdGVsJm5ic3A7Jmx0O2FudXBAYnJhaW5m
YXVsdC5vcmcmZ3Q7DTxiciAvPi0tLTxiciAvPiZuYnNwO2FyY2gvcmlzY3Yva3ZtL21tdS5jJm5i
c3A7fCZuYnNwOzMmbmJzcDsrKys8YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQs
Jm5ic3A7MyZuYnNwO2luc2VydGlvbnMoKyk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5i
c3A7YS9hcmNoL3Jpc2N2L2t2bS9tbXUuYyZuYnNwO2IvYXJjaC9yaXNjdi9rdm0vbW11LmM8YnIg
Lz5pbmRleCZuYnNwOzU3MGMwMzcxYjg1ZTguLjViOTJiMjU2YWUyMmMmbmJzcDsxMDA2NDQ8YnIg
Lz4tLS0mbmJzcDthL2FyY2gvcmlzY3Yva3ZtL21tdS5jPGJyIC8+KysrJm5ic3A7Yi9hcmNoL3Jp
c2N2L2t2bS9tbXUuYzxiciAvPkBAJm5ic3A7LTE2NCw2Jm5ic3A7KzE2NCw5Jm5ic3A7QEAmbmJz
cDt2b2lkJm5ic3A7a3ZtX2FyY2hfbW11X2VuYWJsZV9sb2dfZGlydHlfcHRfbWFza2VkKHN0cnVj
dCZuYnNwO2t2bSZuYnNwOyprdm0sPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
a3ZtX3Jpc2N2X2dzdGFnZV9pbml0KCZhbXA7Z3N0YWdlLCZuYnNwO2t2bSk7PGJyIC8+Jm5ic3A7
DTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2t2bV9yaXNjdl9nc3RhZ2Vfd3Bf
cmFuZ2UoJmFtcDtnc3RhZ2UsJm5ic3A7c3RhcnQsJm5ic3A7ZW5kKTs8YnIgLz4rPGJyIC8+KyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5ic3A7KGt2bV9kaXJ0eV9sb2dfbWFudWFsX3Byb3Rl
Y3RfYW5kX2luaXRfc2V0KGt2bSkpPGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO21tdV9zcGxpdF9odWdlX3BhZ2VzKCZhbXA7Z3N0YWdlLCZuYnNw
O3N0YXJ0LCZuYnNwO2VuZCk7PGJyIC8+Jm5ic3A7fTxiciAvPiZuYnNwOw08YnIgLz4mbmJzcDt2
b2lkJm5ic3A7a3ZtX2FyY2hfc3luY19kaXJ0eV9sb2coc3RydWN0Jm5ic3A7a3ZtJm5ic3A7Kmt2
bSwmbmJzcDtzdHJ1Y3QmbmJzcDtrdm1fbWVtb3J5X3Nsb3QmbmJzcDsqbWVtc2xvdCk8YnIgLz4t
LSZuYnNwOw08YnIgLz4yLjQzLjU8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

