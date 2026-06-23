Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D13D564B;
	Tue, 23 Jun 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216867; cv=none; b=H9NXjO4Np2RgVm0fRhqJqqmggy0adOKxmOnbigAV5V4kNSgkknlA2g39/FEKpKCmWzYv2y/xDJqwoDpcycpBdkIkbaZ0fMGLmo/AqANbNSylxDt96IbhwhP8G19+GIFQaPwFIaXVC+m2rSdU0g0gsbcfHixU3AACSHw45wZmWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216867; c=relaxed/simple;
	bh=viPLsN6/kEIgRUIvQ40N4fSKcsSmqltw7GvVBLfmqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6sDNzGKEKR5eqp//tE++7c0kIRMoFRvKy0jHiWSL6VBDEE2C/XefhoR2boCXQkah4SPkm9M7tk4h3SSq5x2iXDuuXkcYt9PsTiANiTef9pCGh2OfENk1+TDcJMsUiCB400B35IIU0/8jKLiwB/dycdqXc5RUrrAvXZGaxqEAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gl3s01b3qz4xNt9;
	Tue, 23 Jun 2026 20:14:12 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 65NCE7IH004906;
	Tue, 23 Jun 2026 20:14:07 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 23 Jun 2026 20:14:10 +0800
X-Zmail-TransId: 3e816a3a7891006-04697
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
Subject: [PATCH v3 1/5] RISC-V: KVM: Add the split page cache for ioctl context
Date: Tue, 23 Jun 2026 20:13:09 +0800
Message-ID: <20260623121332.78514-2-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 65NCE7IH004906
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 23 Jun 2026 20:14:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3A7894.000/4gl3s01b3qz4xNt9



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

QWRkIHRoZSBzcGxpdCBwYWdlIGNhY2hlIGZvciBkaXJ0eSBsb2dnaW5nIGVuYWJsZW1lbnQgYW5k
IHRoZQ0KS1ZNX0NMRUFSX0RJUlRZX0xPRyBpb2N0bC4NCg0KU2lnbmVkLW9mZi1ieTogV2FuZyBZ
ZWNoYW8gPHdhbmcueWVjaGFvMjU1QHp0ZS5jb20uY24+DQotLS0NCiBhcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2t2bV9ob3N0LmggfCAxICsNCiBhcmNoL3Jpc2N2L2t2bS9tbXUuYyAgICAgICAgICAg
ICAgfCAzICsrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2t2bV9ob3N0LmgNCmluZGV4IDYwMDE3Y2VlYzlkMmEuLjY5ZjczZmQxMDZhOTQgMTAw
NjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCisrKyBiL2FyY2gv
cmlzY3YvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KQEAgLTg2LDYgKzg2LDcgQEAgc3RydWN0IGt2
bV9hcmNoIHsNCiAJcGdkX3QgKnBnZDsNCiAJcGh5c19hZGRyX3QgcGdkX3BoeXM7DQogCXVuc2ln
bmVkIGxvbmcgcGdkX2xldmVsczsNCisJc3RydWN0IGt2bV9tbXVfbWVtb3J5X2NhY2hlIHBnZF9z
cGxpdF9wYWdlX2NhY2hlOw0KIA0KIAkvKiBHdWVzdCBUaW1lciAqLw0KIAlzdHJ1Y3Qga3ZtX2d1
ZXN0X3RpbWVyIHRpbWVyOw0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva3ZtL21tdS5jIGIvYXJj
aC9yaXNjdi9rdm0vbW11LmMNCmluZGV4IDA4MmY5YjI2MTczMzguLmQ2OWZiYTdkOGU5YTYgMTAw
NjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2t2bS9tbXUuYw0KKysrIGIvYXJjaC9yaXNjdi9rdm0vbW11
LmMNCkBAIC02NzYsNiArNjc2LDcgQEAgaW50IGt2bV9yaXNjdl9tbXVfYWxsb2NfcGdkKHN0cnVj
dCBrdm0gKmt2bSkNCiAJa3ZtLT5hcmNoLnBnZCA9IHBhZ2VfdG9fdmlydChwZ2RfcGFnZSk7DQog
CWt2bS0+YXJjaC5wZ2RfcGh5cyA9IHBhZ2VfdG9fcGh5cyhwZ2RfcGFnZSk7DQogCWt2bS0+YXJj
aC5wZ2RfbGV2ZWxzID0ga3ZtX3Jpc2N2X2dzdGFnZV9tYXhfcGdkX2xldmVsczsNCisJa3ZtLT5h
cmNoLnBnZF9zcGxpdF9wYWdlX2NhY2hlLmdmcF96ZXJvID0gX19HRlBfWkVSTzsNCiANCiAJcmV0
dXJuIDA7DQogfQ0KQEAgLTcwMyw2ICs3MDQsOCBAQCB2b2lkIGt2bV9yaXNjdl9tbXVfZnJlZV9w
Z2Qoc3RydWN0IGt2bSAqa3ZtKQ0KIA0KIAlpZiAocGdkKQ0KIAkJZnJlZV9wYWdlcygodW5zaWdu
ZWQgbG9uZylwZ2QsIGdldF9vcmRlcihrdm1fcmlzY3ZfZ3N0YWdlX3BnZF9zaXplKSk7DQorDQor
CWt2bV9tbXVfZnJlZV9tZW1vcnlfY2FjaGUoJmt2bS0+YXJjaC5wZ2Rfc3BsaXRfcGFnZV9jYWNo
ZSk7DQogfQ0KIA0KIHZvaWQga3ZtX3Jpc2N2X21tdV91cGRhdGVfaGdhdHAoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1KQ0KLS0gDQoyLjQzLjU=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

QWRkJm5ic3A7dGhlJm5ic3A7c3BsaXQmbmJzcDtwYWdlJm5ic3A7Y2FjaGUmbmJzcDtmb3ImbmJz
cDtkaXJ0eSZuYnNwO2xvZ2dpbmcmbmJzcDtlbmFibGVtZW50Jm5ic3A7YW5kJm5ic3A7dGhlPGJy
IC8+S1ZNX0NMRUFSX0RJUlRZX0xPRyZuYnNwO2lvY3RsLjxiciAvPg08YnIgLz5TaWduZWQtb2Zm
LWJ5OiZuYnNwO1dhbmcmbmJzcDtZZWNoYW8mbmJzcDsmbHQ7d2FuZy55ZWNoYW8yNTVAenRlLmNv
bS5jbiZndDsNPGJyIC8+LS0tPGJyIC8+Jm5ic3A7YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oJm5ic3A7fCZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7YXJjaC9yaXNjdi9rdm0vbW11
LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7MyZuYnNwOysrKzxiciAvPiZuYnNw
OzImbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7NCZuYnNwO2luc2VydGlvbnMoKyk8YnIg
Lz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmgmbmJzcDtiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20va3ZtX2hvc3QuaDxiciAvPmlu
ZGV4Jm5ic3A7NjAwMTdjZWVjOWQyYS4uNjlmNzNmZDEwNmE5NCZuYnNwOzEwMDY0NDxiciAvPi0t
LSZuYnNwO2EvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9rdm1faG9zdC5oPGJyIC8+KysrJm5ic3A7
Yi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2t2bV9ob3N0Lmg8YnIgLz5AQCZuYnNwOy04Niw2Jm5i
c3A7Kzg2LDcmbmJzcDtAQCZuYnNwO3N0cnVjdCZuYnNwO2t2bV9hcmNoJm5ic3A7ezxiciAvPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3BnZF90Jm5ic3A7KnBnZDs8YnIgLz4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtwaHlzX2FkZHJfdCZuYnNwO3BnZF9waHlzOzxiciAvPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3Vuc2lnbmVkJm5ic3A7bG9uZyZuYnNwO3BnZF9s
ZXZlbHM7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0cnVjdCZuYnNwO2t2bV9tbXVf
bWVtb3J5X2NhY2hlJm5ic3A7cGdkX3NwbGl0X3BhZ2VfY2FjaGU7PGJyIC8+Jm5ic3A7DTxiciAv
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy8qJm5ic3A7R3Vlc3QmbmJzcDtUaW1lciZu
YnNwOyovPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RydWN0Jm5ic3A7a3Zt
X2d1ZXN0X3RpbWVyJm5ic3A7dGltZXI7PGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9hcmNo
L3Jpc2N2L2t2bS9tbXUuYyZuYnNwO2IvYXJjaC9yaXNjdi9rdm0vbW11LmM8YnIgLz5pbmRleCZu
YnNwOzA4MmY5YjI2MTczMzguLmQ2OWZiYTdkOGU5YTYmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJz
cDthL2FyY2gvcmlzY3Yva3ZtL21tdS5jPGJyIC8+KysrJm5ic3A7Yi9hcmNoL3Jpc2N2L2t2bS9t
bXUuYzxiciAvPkBAJm5ic3A7LTY3Niw2Jm5ic3A7KzY3Niw3Jm5ic3A7QEAmbmJzcDtpbnQmbmJz
cDtrdm1fcmlzY3ZfbW11X2FsbG9jX3BnZChzdHJ1Y3QmbmJzcDtrdm0mbmJzcDsqa3ZtKTxiciAv
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2t2bS0mZ3Q7YXJjaC5wZ2QmbmJzcDs9Jm5i
c3A7cGFnZV90b192aXJ0KHBnZF9wYWdlKTs8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDtrdm0tJmd0O2FyY2gucGdkX3BoeXMmbmJzcDs9Jm5ic3A7cGFnZV90b19waHlzKHBnZF9w
YWdlKTs8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtrdm0tJmd0O2FyY2gucGdk
X2xldmVscyZuYnNwOz0mbmJzcDtrdm1fcmlzY3ZfZ3N0YWdlX21heF9wZ2RfbGV2ZWxzOzxiciAv
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtrdm0tJmd0O2FyY2gucGdkX3NwbGl0X3BhZ2VfY2Fj
aGUuZ2ZwX3plcm8mbmJzcDs9Jm5ic3A7X19HRlBfWkVSTzs8YnIgLz4mbmJzcDsNPGJyIC8+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJuJm5ic3A7MDs8YnIgLz4mbmJzcDt9PGJy
IC8+QEAmbmJzcDstNzAzLDYmbmJzcDsrNzA0LDgmbmJzcDtAQCZuYnNwO3ZvaWQmbmJzcDtrdm1f
cmlzY3ZfbW11X2ZyZWVfcGdkKHN0cnVjdCZuYnNwO2t2bSZuYnNwOyprdm0pPGJyIC8+Jm5ic3A7
DTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5ic3A7KHBnZCk8YnIgLz4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtmcmVl
X3BhZ2VzKCh1bnNpZ25lZCZuYnNwO2xvbmcpcGdkLCZuYnNwO2dldF9vcmRlcihrdm1fcmlzY3Zf
Z3N0YWdlX3BnZF9zaXplKSk7PGJyIC8+KzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtr
dm1fbW11X2ZyZWVfbWVtb3J5X2NhY2hlKCZhbXA7a3ZtLSZndDthcmNoLnBnZF9zcGxpdF9wYWdl
X2NhY2hlKTs8YnIgLz4mbmJzcDt9PGJyIC8+Jm5ic3A7DTxiciAvPiZuYnNwO3ZvaWQmbmJzcDtr
dm1fcmlzY3ZfbW11X3VwZGF0ZV9oZ2F0cChzdHJ1Y3QmbmJzcDtrdm1fdmNwdSZuYnNwOyp2Y3B1
KTxiciAvPi0tJm5ic3A7DTxiciAvPjIuNDMuNTxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

