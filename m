Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657A39EF27
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773293156; cv=none; b=ru0cdCgau3lw/RN3vFzSZOhfqOCn/lE4ScNqO2TbhdQh2v8ORBFYIAnjCB1+iUyZ1D/f2QRAweOilLw/nI0doia8oM9n6Do02gQUMIVmvgafw6ZVWd9SV0fObAKpS0GZaowYk6vVpIfEBez8RcsIAE4ONosBuJYsi4f047cIskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773293156; c=relaxed/simple;
	bh=DxJEvkgHr4puc03vqDO9Dqctx7zfYcR7uZZBkxxVImo=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Subject; b=Pv1S9ziByaF6Pq1kE2i56wegschZbZXE9ZeslwjL+V5reZOmAzauobUOt2KPEV5OfJNXCfKRnS2dxPBEVkhanzeNGb5c9MkBN0MB2KIW64GRgYNb26p3iDLqYG4rOggDwccR/H7A8SjKaBqrvZmdfIapL7xzqYqeCcWYbNOoG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kEU7emGe; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kEU7emGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773293146; bh=DxJEvkgHr4puc03vqDO9Dqctx7zfYcR7uZZBkxxVImo=;
	h=From:To:Cc:Subject;
	b=kEU7emGeyoyOkb0nfjf+0TnizmkAKqEkCjRPwKC1SUzx83aD0v3uwRRJcN2ss0hj8
	 utIDTlvdo96UgKg5Cbk4IgAvv9Ig6mDps1wTBCl/Amsxqt1uS90H63uunmqSrlXyx9
	 KMEuX9HnxXj59GWJVccLE54lkINlTknJORvcT7mE=
Received: from 192.168.1.215 ([240e:380:908:ca00:7c6a:6c75:2bb0:f77d])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 66C2C25C; Thu, 12 Mar 2026 13:25:44 +0800
X-QQ-mid: xmsmtpt1773293144tzcal2pxd
Message-ID: <tencent_91ECB0E3CC228CF0003116D210CC329D6509@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJZulQIRZ5iZlSB0e7CPE6Vc6hKEq4TUOcIeUNd9Q+J/kCwZJe+B
	 UWq2lMJlRX7QsBMmrJ5YXT1xzJLnp/6il/bXul1HiwLA+ujTClBdpN0w3hUvo61R099JknF8Y8ed
	 yc1gstQtbO2jCrwNMqJMcecq9gTg2HJ+Bx+JgKYQloDzwchR7sDojOxENSJ4pzMy675AXJx2e5Q3
	 Exro0J+n5bmE9yFvVsUGEdVXzBLkpbZ0BE7fRR8BA90LYDhrXV2rySVP4TjvEreXMiEsi/S5mf9k
	 28RqLgF/h/OVwS4InOpL331KlYTvG9KAwiDjpCPkT2hbamfKOZoJ77CE/NHGaosYV5cua0BjtZDI
	 hBw+FFDPVMQ4CySH2/u680zwMeNwV57D47STBZRZoCKCyK4qvD4lnBdEwOjzqliX2JDWYHZGp6Yl
	 LjTB/MEJy5+XX/RqjurmhJacgCU7LzG9QbA1uuyBkp17nHtmV8bh4OWyIuQawE2nzL2O775PMkC9
	 Ah4VE86uIeNsyxFeCxcdqzRcwcFielfTnZlyoSkepWEqIDZu95wNl9unBBgKYsvymDpkLelvoPfr
	 1m5Q9iZbgACWbZOzQAuJ57eawPs6ioEflBg1D7LW6kZHxss94AGinfG9Y/tXm/jSwh9DiLzOcSFY
	 dbwhali7amKF2FFdo38Oz9s4xLjSdQ5gNaOJsTVAgt3HHDBIMw2wu2hrzVteNoYhuXNGgSHpIphN
	 uKSMH/U4KJhN/UDf+0NDuyfnKTT7rUiFiNUQqLGD/7z6fttZpaTNqx8EdpQHy4xZKP0YODvdBlWF
	 zu8tbmww4JKqyAk6g6+pM5PhYGgp44fq9lGu9b+Ua00FCF1a4TkimmJxAuC95XbQRtDsRHKfFRq1
	 Wle1NpJUz6S9iV76KEpv523zZwevgo1bknqdEghKFU4kY5I6H6JkYM+WidDJXHmgElpDzjWtS3CE
	 JivYccMsxO/oRWM7Py+/4GgVhZwGZvyJNh2MvAjfMoIPUJhhhs/cYx6tuffuBsCWaCYLbvgZaLyQ
	 wDuKYqe/rduA/9740dd8t79R8uiREWDXAmMebCQ3WhwJw2Kuqp
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: zhanghao <76824143@qq.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com
Subject: Re: [PATCH 2/3] KVM: x86: Skip directed-yield targets that are not scheduled out

T24gV2VkLCBNYXIgMTIsIDIwMjYsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cgo+IE9uIFN1
biwgRmViIDE1LCAyMDI2LCA3NjgyNDE0M0BxcS5jb20gd3JvdGU6Cj4+IEZyb206IHpoYW5naGFv
IDx6aGFuZ2hhbzFAa3lsaW5vcy5jbj4KPj4gCj4+IFvljp/pgq7ku7blhoXlrrldCj4KPiBb5Zue
5aSN5YaF5a65XQoKSGkgU2VhbiwKClRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIHJldmlldy4g
SSdkIGxpa2UgdG8gcHJvdmlkZSBhZGRpdGlvbmFsIGNvbnRleHQgb24gdGhlIHR3byBuZXcgY2hl
Y2tzIGluIGt2bV92Y3B1X29uX3NwaW4oKSBhbmQgcmVxdWVzdCB5b3VyIGZlZWRiYWNrIG9uIHRo
ZSBpbXBsZW1lbnRhdGlvbi4KCiMjIENvZGUgaW4gUXVlc3Rpb24KCi8qCiAqIGt2bV92Y3B1X3dh
a2VfdXAoKSBjYW4gcmFjZSB3aXRoIGt2bV9zY2hlZF9pbigpIGFuZCBsZWF2ZSBAcmVhZHkKICog
dHJ1ZSBmb3IgYSBydW5uaW5nIHZDUFUuIEZpbHRlciBvdXQgdkNQVXMgdGhhdCBhcmUgbm90IGN1
cnJlbnRseQogKiBzY2hlZHVsZWQgb3V0IHRvIGF2b2lkIGZ1dGlsZSBkaXJlY3RlZC15aWVsZCBh
dHRlbXB0cy4KICovCmlmICghUkVBRF9PTkNFKHZjcHUtPnNjaGVkdWxlZF9vdXQpKQogICAgY29u
dGludWU7CgovKgogKiBBZGRpdGlvbmFsbHksIHNraXAgdkNQVXMgdGhhdCBhcmUgY3VycmVudGx5
IGluIGd1ZXN0IG1vZGUuCiAqIEEgdkNQVSBpbiBJTl9HVUVTVF9NT0RFIGNhbm5vdCBiZSB5aWVs
ZGVkIHRvIHVudGlsIGl0IGV4aXRzCiAqIHRvIGhvc3QgbW9kZS4KICovCmlmIChSRUFEX09OQ0Uo
dmNwdS0+bW9kZSkgPT0gSU5fR1VFU1RfTU9ERSkKICAgIGNvbnRpbnVlOwoKIyMgUmF0aW9uYWxl
IGZvciBUd28gQ2hlY2tzCgpb6K+m57uG6Kej6YeKLi4uXQoKUGxlYXNlIGxldCBtZSBrbm93IGlm
IHlvdSdkIGxpa2UgYW55IGNoYW5nZXMgb3IgaGF2ZSBjb25jZXJucyBhYm91dCB0aGUgYXBwcm9h
Y2guCgpCZXN0IHJlZ2FyZHMsCnpoYW5naGFvCg==

