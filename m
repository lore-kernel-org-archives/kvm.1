Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623A3D5246;
	Tue, 23 Jun 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216862; cv=none; b=aLKXHpHzi3rVSo/10gABFHN3DkpqHqxYakzZgUN8pEdQjAwkGaAIo8P5vPpZzaDZdwicSmj3uiSeykOzbMUS7qeTQFSdoYwIzogcizK9kGSPNyNq9LM04n4Y8Li5Tr7p+ebNPmyounZVJdG76Pe2d3ntJ+hxcJBA/WVDAVHYHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216862; c=relaxed/simple;
	bh=zRtgBZwUuxlLShujzzd4Gx4aevS1bRQv/Wgh9/2QAmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MP/PxyFQInOfoDO/LGhqku98vin74lmpJJ2z+kaAjNxQPQwZhpA/WmiA3zrWxqZpqx65dXOJGkAiBl8v5Xc69mLiKGaa1b7h/n5t7LxxOGUj6OX1TH2SyTsjp807aIr90SXJL1fnX3OMn2Uvgl1wrbhyXTcU9R0eE7NE/Ya4RMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gl3s65jm2z5B12h;
	Tue, 23 Jun 2026 20:14:18 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 65NCEDYw041662;
	Tue, 23 Jun 2026 20:14:13 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 23 Jun 2026 20:14:16 +0800
X-Zmail-TransId: 3e816a3a7897006-046bf
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
Subject: [PATCH v3 3/5] RISC-V: KVM: Remove redundant TLB flush operations
Date: Tue, 23 Jun 2026 20:13:11 +0800
Message-ID: <20260623121332.78514-4-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 65NCEDYw041662
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 23 Jun 2026 20:14:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3A789A.001/4gl3s65jm2z5B12h



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

VGhlIGZ1bmN0aW9uIGt2bV9hcmNoX21tdV9lbmFibGVfbG9nX2RpcnR5X3B0X21hc2tlZCgpIGlz
IGNhbGxlZCBieQ0Ka3ZtX3ZtX2lvY3RsX3Jlc2V0X2RpcnR5X3BhZ2VzKCkgYW5kIGt2bV9jbGVh
cl9kaXJ0eV9sb2dfcHJvdGVjdCgpLg0KQm90aCBjYWxsZXJzIGFscmVhZHkgcGVyZm9ybSBhIFRM
QiBmbHVzaCBhZnRlciBlbmFibGluZyBkaXJ0eSBsb2dnaW5nLA0Kc28gdGhlIFRMQiBmbHVzaCBp
bnNpZGUga3ZtX2FyY2hfbW11X2VuYWJsZV9sb2dfZGlydHlfcHRfbWFza2VkKCkgaXMNCnVubmVj
ZXNzYXJ5LiBSZW1vdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IFdhbmcgWWVjaGFvIDx3YW5nLnll
Y2hhbzI1NUB6dGUuY29tLmNuPg0KLS0tDQogYXJjaC9yaXNjdi9rdm0vbW11LmMgfCA2ICstLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3Yva3ZtL21tdS5jIGIvYXJjaC9yaXNjdi9rdm0vbW11LmMNCmlu
ZGV4IGY5YzM5NjgxN2UwZDguLjU3MGMwMzcxYjg1ZTggMTAwNjQ0DQotLS0gYS9hcmNoL3Jpc2N2
L2t2bS9tbXUuYw0KKysrIGIvYXJjaC9yaXNjdi9rdm0vbW11LmMNCkBAIC0xNjAsMTQgKzE2MCwx
MCBAQCB2b2lkIGt2bV9hcmNoX21tdV9lbmFibGVfbG9nX2RpcnR5X3B0X21hc2tlZChzdHJ1Y3Qg
a3ZtICprdm0sDQogCXBoeXNfYWRkcl90IHN0YXJ0ID0gKGJhc2VfZ2ZuICsgIF9fZmZzKG1hc2sp
KSA8PCBQQUdFX1NISUZUOw0KIAlwaHlzX2FkZHJfdCBlbmQgPSAoYmFzZV9nZm4gKyBfX2Zscyht
YXNrKSArIDEpIDw8IFBBR0VfU0hJRlQ7DQogCXN0cnVjdCBrdm1fZ3N0YWdlIGdzdGFnZTsNCi0J
Ym9vbCBmbHVzaDsNCiANCiAJa3ZtX3Jpc2N2X2dzdGFnZV9pbml0KCZnc3RhZ2UsIGt2bSk7DQog
DQotCWZsdXNoID0ga3ZtX3Jpc2N2X2dzdGFnZV93cF9yYW5nZSgmZ3N0YWdlLCBzdGFydCwgZW5k
KTsNCi0JaWYgKGZsdXNoKQ0KLQkJa3ZtX2ZsdXNoX3JlbW90ZV90bGJzX3JhbmdlKGt2bSwgc3Rh
cnQgPj4gUEFHRV9TSElGVCwNCi0JCQkJCSAgICAoZW5kIC0gc3RhcnQpID4+IFBBR0VfU0hJRlQp
Ow0KKwlrdm1fcmlzY3ZfZ3N0YWdlX3dwX3JhbmdlKCZnc3RhZ2UsIHN0YXJ0LCBlbmQpOw0KIH0N
CiANCiB2b2lkIGt2bV9hcmNoX3N5bmNfZGlydHlfbG9nKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0
IGt2bV9tZW1vcnlfc2xvdCAqbWVtc2xvdCkNCi0tIA0KMi40My41


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhlJm5ic3A7ZnVuY3Rpb24mbmJzcDtrdm1fYXJjaF9tbXVfZW5hYmxlX2xvZ19kaXJ0eV9wdF9t
YXNrZWQoKSZuYnNwO2lzJm5ic3A7Y2FsbGVkJm5ic3A7Ynk8YnIgLz5rdm1fdm1faW9jdGxfcmVz
ZXRfZGlydHlfcGFnZXMoKSZuYnNwO2FuZCZuYnNwO2t2bV9jbGVhcl9kaXJ0eV9sb2dfcHJvdGVj
dCgpLjxiciAvPkJvdGgmbmJzcDtjYWxsZXJzJm5ic3A7YWxyZWFkeSZuYnNwO3BlcmZvcm0mbmJz
cDthJm5ic3A7VExCJm5ic3A7Zmx1c2gmbmJzcDthZnRlciZuYnNwO2VuYWJsaW5nJm5ic3A7ZGly
dHkmbmJzcDtsb2dnaW5nLDxiciAvPnNvJm5ic3A7dGhlJm5ic3A7VExCJm5ic3A7Zmx1c2gmbmJz
cDtpbnNpZGUmbmJzcDtrdm1fYXJjaF9tbXVfZW5hYmxlX2xvZ19kaXJ0eV9wdF9tYXNrZWQoKSZu
YnNwO2lzPGJyIC8+dW5uZWNlc3NhcnkuJm5ic3A7UmVtb3ZlJm5ic3A7aXQuPGJyIC8+DTxiciAv
PlNpZ25lZC1vZmYtYnk6Jm5ic3A7V2FuZyZuYnNwO1llY2hhbyZuYnNwOyZsdDt3YW5nLnllY2hh
bzI1NUB6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDthcmNoL3Jpc2N2L2t2bS9t
bXUuYyZuYnNwO3wmbmJzcDs2Jm5ic3A7Ky0tLS0tPGJyIC8+Jm5ic3A7MSZuYnNwO2ZpbGUmbmJz
cDtjaGFuZ2VkLCZuYnNwOzEmbmJzcDtpbnNlcnRpb24oKyksJm5ic3A7NSZuYnNwO2RlbGV0aW9u
cygtKTxiciAvPg08YnIgLz5kaWZmJm5ic3A7LS1naXQmbmJzcDthL2FyY2gvcmlzY3Yva3ZtL21t
dS5jJm5ic3A7Yi9hcmNoL3Jpc2N2L2t2bS9tbXUuYzxiciAvPmluZGV4Jm5ic3A7ZjljMzk2ODE3
ZTBkOC4uNTcwYzAzNzFiODVlOCZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvYXJjaC9yaXNj
di9rdm0vbW11LmM8YnIgLz4rKysmbmJzcDtiL2FyY2gvcmlzY3Yva3ZtL21tdS5jPGJyIC8+QEAm
bmJzcDstMTYwLDE0Jm5ic3A7KzE2MCwxMCZuYnNwO0BAJm5ic3A7dm9pZCZuYnNwO2t2bV9hcmNo
X21tdV9lbmFibGVfbG9nX2RpcnR5X3B0X21hc2tlZChzdHJ1Y3QmbmJzcDtrdm0mbmJzcDsqa3Zt
LDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3BoeXNfYWRkcl90Jm5ic3A7c3Rh
cnQmbmJzcDs9Jm5ic3A7KGJhc2VfZ2ZuJm5ic3A7KyZuYnNwOyZuYnNwO19fZmZzKG1hc2spKSZu
YnNwOyZsdDsmbHQ7Jm5ic3A7UEFHRV9TSElGVDs8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDtwaHlzX2FkZHJfdCZuYnNwO2VuZCZuYnNwOz0mbmJzcDsoYmFzZV9nZm4mbmJzcDsr
Jm5ic3A7X19mbHMobWFzaykmbmJzcDsrJm5ic3A7MSkmbmJzcDsmbHQ7Jmx0OyZuYnNwO1BBR0Vf
U0hJRlQ7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RydWN0Jm5ic3A7a3Zt
X2dzdGFnZSZuYnNwO2dzdGFnZTs8YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Ym9vbCZu
YnNwO2ZsdXNoOzxiciAvPiZuYnNwOw08YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDtrdm1fcmlzY3ZfZ3N0YWdlX2luaXQoJmFtcDtnc3RhZ2UsJm5ic3A7a3ZtKTs8YnIgLz4mbmJz
cDsNPGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2ZsdXNoJm5ic3A7PSZuYnNwO2t2bV9y
aXNjdl9nc3RhZ2Vfd3BfcmFuZ2UoJmFtcDtnc3RhZ2UsJm5ic3A7c3RhcnQsJm5ic3A7ZW5kKTs8
YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDsoZmx1c2gpPGJyIC8+LSZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2t2bV9mbHVzaF9yZW1v
dGVfdGxic19yYW5nZShrdm0sJm5ic3A7c3RhcnQmbmJzcDsmZ3Q7Jmd0OyZuYnNwO1BBR0VfU0hJ
RlQsPGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyhlbmQmbmJzcDstJm5ic3A7
c3RhcnQpJm5ic3A7Jmd0OyZndDsmbmJzcDtQQUdFX1NISUZUKTs8YnIgLz4rJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7a3ZtX3Jpc2N2X2dzdGFnZV93cF9yYW5nZSgmYW1wO2dzdGFnZSwmbmJzcDtz
dGFydCwmbmJzcDtlbmQpOzxiciAvPiZuYnNwO308YnIgLz4mbmJzcDsNPGJyIC8+Jm5ic3A7dm9p
ZCZuYnNwO2t2bV9hcmNoX3N5bmNfZGlydHlfbG9nKHN0cnVjdCZuYnNwO2t2bSZuYnNwOyprdm0s
Jm5ic3A7c3RydWN0Jm5ic3A7a3ZtX21lbW9yeV9zbG90Jm5ic3A7Km1lbXNsb3QpPGJyIC8+LS0m
bmJzcDsNPGJyIC8+Mi40My41PGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

