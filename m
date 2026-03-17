Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2E32FA2A
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747517; cv=none; b=GMXzxQ35Bkok+AgnsQ2yVg7gObhaO3GP4O1XCiriQPtk0MGfxM7jh5qyql2CkA2CZbObtNfl7zxEhRKr46AM2OEh+Lmr+QKxLlrvcYsVJv4EI7Sq3z4u9IbLp9AQMvvAM8oiwsU3IwcHc9YExhCyoO5al9Tv9hw6C1FWZFLqWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747517; c=relaxed/simple;
	bh=zHDJCqDW5sPFCzyEKLR4ACypUDaiDDIoLV/RVsztJaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGlsvMQo1QZta2oLyERUfiWw33gEbRCNTUlGHCkpjPyqLbxRLS6GGZajOe8Fph+Ltkr+gEuql3x8HNTt4RwyUfblE4RZ0ueEOTX/Ea3/Jl60sLro01tNS6TMJdR85JobqbycVVrGle9+suSZVqP3qn+Ns1gsTRxiRBQSoawkqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAYICqRf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAYICqRf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486507134e4so6171035e9.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747515; x=1774352315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHDJCqDW5sPFCzyEKLR4ACypUDaiDDIoLV/RVsztJaY=;
        b=UAYICqRfYIUi/p7RX9njESrrQCHEQTF8Y0dmjJ/EmCmzMZTZLQiitSkotdN1yupcvQ
         7fZ5EHcCoREUUeTiGPxmpyZU/wrElT4tJmcLtftLbQwhlgHUBE90n0gXIQChGt0Qq41/
         s0ktxfs90MPTUMQEe4hk5CfXVsR4mD/PbI8MX8NT3xypdO4eDhO7p8YGWcWAa4cV8/XN
         krrt3pH8CWRa0ZfLgl2UWUvHFM7nZSIQHHqL330OxEQO/ueA6YWvVC/Q0H9lryAtv9Vi
         y9md3o5z/x5nZt9GfHgR4uIuYWP2YdhYEjzugZ8ZehYTU6qQkcQtRv3o/aM96qqdd+wZ
         dvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747515; x=1774352315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHDJCqDW5sPFCzyEKLR4ACypUDaiDDIoLV/RVsztJaY=;
        b=hc31Smhf5ByFAF/qqSLKnCkWMWKroiRV4PdF2sHvpo6H/jcR+0PpeeeZwVZZfm74Kb
         8ut3X6EvwpRoOVo+IZY/iTFqv27j2MgvdjPM/MAj2T4TGC69PE7OprBfFQGD4d6fPx1K
         RKEMd5a5qYFKtHK/Gt+Ye72uyOjN/fYE8ohbL648Pu4zFLTnUeANAWjGn5YlCXiy9CZQ
         GZr3M/2hBV5bn9uHWJ8A1O/pJZI6zeCCUbTqbA77MM7EkxgJk+8yvYwiyVnn2H1qtMJv
         02jcnYQo6cmTOKMwutJe+yp/OBdXiKNppLLplanqPMYYbqj+Tv566h67HPy1JdpneMKK
         LWmw==
X-Gm-Message-State: AOJu0YxAWJwwPTOq6wchIyrznPo5VcJEmELp1M4FKrJRDduvftlQ6tdS
	T1zKJCkSibeTb6mZqxLacYrlBB7nf7eUSuPF4bKZ6oDmOCMTzYve4v3v
X-Gm-Gg: ATEYQzz8mrAQQ4HfQelrJk2SdHv5Dc5KRxSS9GM+5mTiP6EA+2VCG9fBOrLiNWBPY68
	WzVxscBQ8D0hFUEqX+GwCfEqwN4r+I/RYXK6PLHCQam23qI967sMEiYcx3QhetMGZIM2P31uaP7
	5EJYzCcaniPxoX+249RC3l+VbzZBp6j0EnPPKUHV153O0Ps4gzV5io0rkywI9CMpqtaW7bVXIZQ
	O5LYbWWj0ZNVYX6f5xdeIDz3Ny+HWEkiKhieE1qoicuCHeMZcLrbw+udzfDeanOhkcaa5TmnrKv
	9V4DrJt4tS145fbJK5hFprobMgUJV2d2/fjcKmQSmlSCvlu+Jdut2DGa/us9uUVQc9VzPpVQTmc
	cx+HUsWJc1HnrDLeuYx/oFTDusfhvKrLxU0vQEuCV2CMavGeKzL14tztZAXrDqGo0X8YaAiKrwe
	vVgneXLNYcULThksJwMua+j8XhMgpia62pZczqu8uIWEcPbpJFDCWDwo5j3/+m5YMTPjY8oK8DZ
	yq7pUesA5tUnMBK467b
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-485566c6a8cmr287386835e9.2.1773747514496;
        Tue, 17 Mar 2026 04:38:34 -0700 (PDT)
Received: from DesktopTC.localdomain (host-87-27-45-215.business.telecomitalia.it. [87.27.45.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaee04fsm62721365e9.13.2026.03.17.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:38:34 -0700 (PDT)
From: Tommaso Califano <califano.tommaso@gmail.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Eduardo Habkost <eduardo@habkost.net>,
	Markus Armbruster <armbru@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Oliver Steffen <osteffen@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Tommaso Califano <califano.tommaso@gmail.com>
Subject: [PATCH 0/5] i386/sev: Add TCG-emulated AMD SEV guest support
Date: Tue, 17 Mar 2026 12:38:35 +0100
Message-ID: <20260317113840.33017-1-califano.tommaso@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogVG9tbWFzbyBDYWxpZmFubyA8Y2FsaWZhbm8udG9tbWFzb0BnbWFpbC5jb20+DQoNClFF
TVUncyBBTUQgU0VWIHN1cHBvcnQgY3VycmVudGx5IHJlcXVpcmVzIEtWTSBvbiBleHBlbnNpdmUg
QU1EIEVQWUMNCmhhcmR3YXJlLCBsaW1pdGluZyBkZXZlbG9wbWVudCBhbmQgdGVzdGluZyBvZiBT
RVYtYXdhcmUgZ3Vlc3Qgc29mdHdhcmUgdG8NCnVzZXJzIHdpdGggc2VydmVyLWdyYWRlIG1hY2hp
bmVzLg0KDQpUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGEgVENHLWVtdWxhdGVkIFNFViBndWVzdCBt
b2RlIHRoYXQgZW5hYmxlcyBTRVYNCnZhbGlkYXRpb24gd2l0aG91dCBoYXJkd2FyZSBkZXBlbmRl
bmNpZXMsIGZvY3VzaW5nIG9uIGZ1bmN0aW9uYWwgdGVzdGluZw0KcmF0aGVyIHRoYW4gcmVwcm9k
dWNpbmcgdGhlIGhhcmR3YXJl4oCZcyBjcnlwdG9ncmFwaGljIGNvbnRleHQuDQoNClRoZSBlbXVs
YXRpb24gZXhwb3NlcyBTRVYgZnJvbSB0aGUgZ3Vlc3QncyBwZXJzcGVjdGl2ZToNCiAtIEV4cG9z
ZWQgQ1BVSUQgbGVhZiAweDgwMDAwMDFGIHRvIGluZGljYXRlIGFjdGl2ZSBzdXBwb3J0Lg0KIC0g
QWN0aXZlIGJpdCAwIGluIE1TUiAweGMwMDEwMTMxIHRvIGVuYWJsZSBTRVYgb24gdGhlIGd1ZXN0
Lg0KIC0gQy1iaXQgbWFuaXB1bGF0aW9uIGluIFBURXMvQ1IzIGZvciBwYWdpbmcgY29uc2lzdGVu
Y3kgd2l0aCB0aGUgaG9zdC4NCiAtIENvbXBsZXRlIFNFViBhdHRlc3RhdGlvbiB3b3JrZmxvdyBm
b3IgaW5qZWN0aW5nIHNlY3JldHMgaW50byBndWVzdA0KICAgbWVtb3J5IChpbmNsdWRpbmcgZGly
ZWN0IGtlcm5lbCBib290IHN1cHBvcnQpLg0KDQpUaGUgZW11bGF0aW9uIHVzZXMgYSBuZXcgUU9N
IG9iamVjdCAic2V2LWVtdWxhdGVkIiwgZGVyaXZlZCBmcm9tDQoic2V2LWd1ZXN0IiwgdG8gbWF4
aW1pemUgcmV1c2Ugb2YgdGhlIGV4aXN0aW5nIFNFViBpbmZyYXN0cnVjdHVyZSB3aGlsZQ0KbWFp
bnRhaW5pbmcgYSBjb21waWxpbmcgZGVwZW5kZW5jeSB3aXRoIEtWTS4NCkJlbG93IGFyZSB0aGUg
cHJvcyBhbmQgY29ucyBvZiB0aGlzIGNob2ljZS4NCg0KSW4gYWRkaXRpb24gdG8gaW5oZXJpdGVk
IGd1ZXN0IHByb3BlcnRpZXMsIHR3byBuZXcgb25lcyBhcmUgYWRkZWQgKGJpbmFyeQ0KZmlsZXM7
IGRlZmF1bHQgYWxsLXplcm8pOg0KIC0gdGlrOiAxNi1ieXRlIFRyYW5zcG9ydCBJbnRlZ3JpdHkg
S2V5IChUSUspIGZvciBtZWFzdXJlbWVudCBITUFDLg0KIC0gdGVrOiAxNi1ieXRlIFRyYW5zcG9y
dCBFbmNyeXB0aW9uIEtleSAoVEVLKSBmb3Igc2VjcmV0IHBheWxvYWQNCiAgIGRlY3J5cHRpb24u
DQoNCkNvZGUgcmV1c2UgYmVuZWZpdHM6DQogLSBTRVYgZGV0ZWN0aW9uIHZpYSBzZXZfZW5hYmxl
ZCgpIGFuZCBUWVBFX1NFVl9DT01NT04gb2JqZWN0IGNhc3QgZW5hYmxlcw0KICAgdGhlIHJlcXVp
cmVkIGNoZWNrcyBmb3IgZW11bGF0aW9uIHdpdGhvdXQgYWRkaW5nIG5ldyBjb25kaXRpb25zIHRv
IHRoZQ0KICAgY29kZWJhc2UuDQogLSBRQVBJIGZpZWxkcyBmb3IgcXVlcnktc2V2L2xhdW5jaC1t
ZWFzdXJlIGluaGVyaXRlZCBmcm9tIFNldkNvbW1vblN0YXRlDQogICBhbmQgU2V2R3Vlc3RTdGF0
ZS4NCiAtIElkZW50aWNhbCBRTVAgaW50ZXJmYWNlIChxdWVyeS1zZXYsIHF1ZXJ5LXNldi1sYXVu
Y2gtbWVhc3VyZSwNCiAgIHNldi1pbmplY3QtbGF1bmNoLXNlY3JldCkgYXMgcmVhbCBTRVYuDQog
LSBTaGFyZWQgc3RhdGUgbWFjaGluZSAoc2V2X3NldF9ndWVzdF9zdGF0ZSgpKTsgb3ZlcnJpZGUg
YmFja2VuZCB2dGFibGUNCiAgIG9ubHkgKGt2bV9pbml0IOKGkiBzZXZfZW11bGF0ZWRfaW5pdCwg
bGF1bmNoX3VwZGF0ZV9kYXRhLCBsYXVuY2hfZmluaXNoLA0KICAgc2V2X2xhdW5jaF9nZXRfbWVh
c3VyZSkuDQoNClRyYWRlLW9mZnM6DQogLSBLVk0gbGlua2FnZTogc2V2LWd1ZXN0IGlzIEtWTS1j
ZW50cmljOyBldmVuIGlmIEtWTSBpcyBub3QgdXNlZCBhdA0KICAgcnVudGltZSwgaXRzIGNvZGUg
aXMgcmVxdWlyZWQgZm9yIGNvbXBpbGF0aW9uLCBzbyBpdCBpcyBub3QgcG9zc2libGUgdG8NCiAg
IHVzZSBlbXVsYXRpb24gd2l0aCAtLWRpc2FibGUta3ZtLg0KDQpFeGFtcGxlIHVzYWdlOg0KDQoJ
LWNwdSAiRVBZQy1NaWxhbiIgXA0KCS1hY2NlbCB0Y2cgXA0KCS1vYmplY3Qgc2V2LWVtdWxhdGVk
LGlkPXNldjAsY2JpdHBvcz00NyxyZWR1Y2VkLXBoeXMtYml0cz0xLFwNCgkJdGlrPS9wYXRoL3Rv
L3Rpay5iaW4sdGVrPS9wYXRoL3RvL3Rlay5iaW4gXA0KCS1tYWNoaW5lIG1lbW9yeS1lbmNyeXB0
aW9uPXNldjANCg0KQnVpbGQgcmVxdWlyZW1lbnRzOg0KDQoJLi4vcWVtdS9jb25maWd1cmUgLS1l
bmFibGUtZ2NyeXB0IC0tZW5hYmxlLWNyeXB0by1hZmFsZw0KDQpUaGVzZSBwcm92aWRlIGxpYmdj
cnlwdCBzdXBwb3J0IGZvciBjcnlwdG8vaG1hYy5oLCBjcnlwdG8vY2lwaGVyLmgsIGFuZA0KY3J5
cHRvL3JhbmRvbS5oLCB1c2VkIGZvcjoNCiAtIEhNQUMtU0hBMjU2IGxhdW5jaCBtZWFzdXJlbWVu
dCAoVElLIGtleSkuDQogLSBTZWNyZXQgcGF5bG9hZCBkZWNyeXB0aW9uIChURUsga2V5KS4NCk5v
dGU6IC0tZGlzYWJsZS1rdm0gdW5zdXBwb3J0ZWQgZHVlIHRvIHNldi1ndWVzdCBpbmhlcml0YW5j
ZSAoS1ZNIGNvZGUNCmxpbmtlZCwgbm8gcnVudGltZSBkZXBlbmRlbmN5KS4NCg0KVG9tbWFzbyBD
YWxpZmFubyAoNSk6DQogIGkzODYvc2V2OiBBZGQgc2V2LWVtdWxhdGVkIFFPTSBvYmplY3Qgd2l0
aCBUQ0cgc3VwcG9ydA0KICB0YXJnZXQvaTM4NjogQWRkIE1TUiBTRVYgc3VwcG9ydCBhbmQgQy1i
aXQgcmVzZXQgb24gVENHDQogIGkzODYvc2V2OiBJbXBsZW1lbnQgU0VWIGxhdW5jaCBzdGF0ZSBz
ZXF1ZW5jZSBhbmQgcXVlcnktc2V2DQogIGkzODYvc2V2OiBBZGQgbGF1bmNoIG1lYXN1cmVtZW50
IGVtdWxhdGlvbiBhbmQgVElLIHByb3BlcnR5DQogIGkzODYvc2V2OiBJbXBsZW1lbnQgZW11bGF0
ZWQgbGF1bmNoIHNlY3JldCBpbmplY3Rpb24gYW5kIFRFSyBwcm9wZXJ0eQ0KDQogYWNjZWwvdGNn
L3RjZy1hbGwuYyAgICAgICAgICAgICAgICAgIHwgIDE4ICstDQogcWFwaS9xb20uanNvbiAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDE5ICsrDQogdGFyZ2V0L2kzODYvY3B1LmggICAgICAgICAg
ICAgICAgICAgIHwgICAyICsNCiB0YXJnZXQvaTM4Ni9zZXYuYyAgICAgICAgICAgICAgICAgICAg
fCA0MDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogdGFyZ2V0L2kzODYvc2V2LmggICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCiB0YXJnZXQvaTM4Ni90Y2cvc3lzdGVtL2V4Y3BfaGVs
cGVyLmMgfCAgMzEgKysNCiB0YXJnZXQvaTM4Ni90Y2cvc3lzdGVtL21pc2NfaGVscGVyLmMgfCAg
MTMgKw0KIDcgZmlsZXMgY2hhbmdlZCwgNDkwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cg0KLS0gDQoyLjUzLjANCg0K
