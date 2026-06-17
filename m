Received: from mail2.rotek.at (mail2.rotek.at [88.116.105.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE13A257E;
	Wed, 17 Jun 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.116.105.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725872; cv=none; b=f1BLshZLSbS7qS3xZUrGSwVmEXz9mFOsw4zrrh/K3QkMaKjT4POUeZo7e8qr9TcK/Dj9SEMt596PPOHRrqRBOVuHEqfWQwxu6f8I9A14GsTRgRBmqTGBUrUSRNJa0YLqfHX0zU7q3e1Oa/h6U14AERqit1QgJBJ2dHRp9VAa330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725872; c=relaxed/simple;
	bh=lA/nvr44w/vyrDjqgmyG8Aphzjx44NqwfH1GLLk96B4=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=Set7PygqfS2t9ZFWCmaS5VyVgPaTjBU0e2+RdcRbF/8s0dzFnZ4MbDb9q1M1om/u+NBetzVHRoI1YRVWkMbXuEMsv6htmjOQuVfqDt0CwR5G+iOzLAssKZNLcPouTk52TdQw6JiT3t2nhQEDb/sYJlT5HOSDqA30x5CYJBc43rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rotek.at; spf=pass smtp.mailfrom=rotek.at; dkim=pass (2048-bit key) header.d=rotek.at header.i=@rotek.at header.b=OZn0h7Ul; arc=none smtp.client-ip=88.116.105.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rotek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rotek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rotek.at header.i=@rotek.at header.b="OZn0h7Ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rotek.at; s=mail2;
	t=1781725857; bh=lA/nvr44w/vyrDjqgmyG8Aphzjx44NqwfH1GLLk96B4=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To:From;
	b=OZn0h7Ulrl38o5HTsnTJmtcQis65ENCk7/X83wPFvVvP5rNtResg1hMGps97eAdUa
	 SRHxk5rHHP7dUH4AJvVl8QSzn/F0G9uApbRdSGxH+LhHMoZhW60znlX2UAZbwYHATJ
	 XD2sOLNIUeg1fVvWyUVlOQoefhCUTEZ/KQ3IKyWnPub3O/Zm4ql7yaoKXbejsxxHpR
	 oIFLwdiJioDnyGzc8JiUc65FGM33iIP+p8iD765N0Cizzpp1Ngb1f5LoIsL9tmgV44
	 tQCL52sHLRoEOssLo++ZxEgL9nVGwGCUqu7bKNOz6m45SOvz7Vg7BZqo5ucDxbHAJe
	 wbtyT2tOrSyJw==
Received: from imap.rotek.at (imap.rotek.at [192.168.168.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by mail2.rotek.at (Postfix) with ESMTPS id 58EF483280;
	Wed, 17 Jun 2026 21:50:57 +0200 (CEST)
Received: from [100.99.16.57] (unknown [100.99.16.57])
	by imap.rotek.at (Postfix) with ESMTP id DFEA16CA82;
	Wed, 17 Jun 2026 21:50:56 +0200 (CEST)
Message-ID: <29662c85-9c4d-404f-b493-a5d1b8c1e19d@rotek.at>
Date: Wed, 17 Jun 2026 21:50:55 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: FW: [RFC PATCH 0/2] KVM: x86: Relay a nested Hyper-V root's vmbus
 posts to L0 // including patches
Content-Language: en-US
References: <11b87e43-dde8-4fbc-a25e-ee7373c8181d@rotek.at>
From: Robert Nowotny <rnowotny@rotek.at>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, jostarks@microsoft.com
In-Reply-To: <11b87e43-dde8-4fbc-a25e-ee7373c8181d@rotek.at>
X-Forwarded-Message-Id: <11b87e43-dde8-4fbc-a25e-ee7373c8181d@rotek.at>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090500000902090604030004"

This is a cryptographically signed message in MIME format.

--------------ms090500000902090604030004
Content-Type: multipart/mixed; boundary="------------oAkJlQkyexkkEkFyf80JxdBZ"

--------------oAkJlQkyexkkEkFyf80JxdBZ
Content-Type: multipart/alternative;
 boundary="------------wveHTjyskrA3gw5g0Va40neh"

--------------wveHTjyskrA3gw5g0Va40neh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

dGhlIHBhdGNoZXMgYXJlIHNtYWxsIC0gYnV0IG5vdCBUSEFUIHNtYWxsLiBmb3Jnb3QgdG8g
YXR0YWNoIHRoZW0sIEkgYW0gDQpzb3JyeS4NClBsZWFzZSBmaW5kIHRoZSBwYXRjaGVzIGF0
dGFjaGVkLg0KUm9iZXJ0IChha2EgYml0cmFub3gpDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQoNClRoaXMgUkZDIGFza3MgZm9yIGRpcmVjdGlvbiBvbiBhIHNtYWxsIEtWTS94ODYg
YWRkaXRpb24gYmVmb3JlIGFkZGluZyBhIA0Kc2VsZnRlc3QNCmFuZCBhbiBTVk0gY291bnRl
cnBhcnQuIEl0IGxldHMgYSBuZXN0ZWQgSHlwZXItViByb290IHBhcnRpdGlvbidzIHZtYnVz
IA0KY29tZSB1cA0Kd2hlbiB0aGUgTDEgaHlwZXJ2aXNvciBydW5zIHVuZGVyIEtWTSB3aXRo
IGEgdXNlcnNwYWNlIFZNTSB0aGF0IG93bnMgdGhlIA0KaG9zdA0Kdm1idXMgZW5kcG9pbnQu
DQoNClBhdGNoIDEgcmVuYW1lcyBuZXN0ZWRfZXZtY3NfbDJfdGxiX2ZsdXNoX2VuYWJsZWQo
KSB0bw0KbmVzdGVkX2V2bWNzX2wyX2RpcmVjdF9oeXBlcmNhbGxfZW5hYmxlZCgpLCBzaW5j
ZSB0aGUgcHJlZGljYXRlIGlzIA0KcmVhbGx5ICJMMQ0KZ3JhbnRlZCB0aGlzIEwyIHRoZSBl
Vk1DUyBkaXJlY3QtaHlwZXJjYWxsIGZhY2lsaXR5IiBhbmQgYSBzZWNvbmQgY2FsbGVyIG5v
dw0Kc2hhcmVzIGl0LiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCg0KUGF0Y2ggMiBhZGRzIHRo
ZSByZWxheS4NCg0KVGhlIHVzZXJzcGFjZSB1c2VyIGlzIE9wZW5WTU0gKGh0dHBzOi8vZ2l0
aHViLmNvbS9taWNyb3NvZnQvb3BlbnZtbSk7IHRoZQ0KY29tcGFuaW9uIGNoYW5nZSB0aGF0
IGVuYWJsZXMgdGhpcyBjYXBhYmlsaXR5IHdpdGggdGhlIGJpdG1hc2sgd2lsbCBiZSANCnBv
c3RlZCB0bw0KT3BlblZNTSBsYXRlci4NCg0KUHJvYmxlbQ0KLS0tLS0tLQ0KQSBXaW5kb3dz
IGd1ZXN0IHRoYXQgZW5hYmxlcyBIeXBlci1WL1ZCUyBydW5zIGl0cyBvd24ga2VybmVsIGFz
IHRoZSByb290DQpwYXJ0aXRpb24gb2YgYSBuZXN0ZWQgaHlwZXJ2aXNvciwgaS5lLiBhcyBh
biBMMiBndWVzdDogZ3Vlc3Qga2VybmVsIC0+DQpuZXN0ZWQgaHlwZXJ2aXNvciAoTDEpIC0+
IEtWTSAoTDApLiBUaGUgcm9vdCdzIHZtYnVzIG5ldmVyIGNvbm5lY3RzLiBJdHMNCkh2UG9z
dE1lc3NhZ2UoSW5pdGlhdGVDb250YWN0KSBpcyBhbiBMMiBWTUNBTEwgdGhhdCBleGl0cyB0
byBMMCBhbmQgaXMNCnJlZmxlY3RlZCB1cCB0byBMMSwgd2hpY2ggaGFzIG5vIHBhdGggdG8g
Zm9yd2FyZCBpdCB0byB0aGUgdXNlcnNwYWNlIA0KVk1NLiBUaGUNCmd1ZXN0IGJ1Z2NoZWNr
cyAweDdCIGVhcmx5IGluIGJvb3QuDQoNCldoYXQgdGhlIHBhdGNoIGRvZXMNCi0tLS0tLS0t
LS0tLS0tLS0tLS0NCkFkZCBhIHBlci1WTSBjYXBhYmlsaXR5IHdob3NlIGFyZ3VtZW50IGlz
IGEgYml0bWFzayBvZiB0aGUgbmVzdGVkIEh5cGVyLVYNCmh5cGVyY2FsbCBjbGFzc2VzIHVz
ZXJzcGFjZSB3YW50cyBrZXB0IGluIEwwIChIdlBvc3RNZXNzYWdlLCBIdlNpZ25hbEV2ZW50
KS4NCkZvciBhIHNlbGVjdGVkIGNsYXNzLCBhbmQgd2hlbiBMMSBoYXMgYXV0aG9yaXplZCB0
aGUgTDIgZm9yIGRpcmVjdCBuZXN0ZWQNCmh5cGVyY2FsbHMgKG5lc3RlZF9ldm1jc19sMl9k
aXJlY3RfaHlwZXJjYWxsX2VuYWJsZWQoKSwgdGhlIGdhdGUgS1ZNIGFscmVhZHkNCmhvbm9y
cyBmb3IgdGhlIEwyIFRMQi1mbHVzaCBoeXBlcmNhbGwpLCB0aGUgTDIgVk1DQUxMIGlzIGhh
bmRsZWQgaW4gTDAgDQppbnN0ZWFkDQpvZiByZWZsZWN0ZWQgdG8gTDE6IEtWTSBjbGVhcnMg
dGhlIG5lc3RlZCBiaXQsIHRyYW5zbGF0ZXMgdGhlIEwyIEdQQSBpbiB0aGUNCmlucHV0IHBh
cmFtZXRlciB0byBhbiBMMSBHUEEgdmlhIHRoZSBuZXN0ZWQgTU1VLCBhbmQgbGV0cyB0aGUg
ZXhpc3RpbmcNCmh5cGVyY2FsbCBwYXRoIGRlbGl2ZXIgdGhlIHBvc3QgdG8gdXNlcnNwYWNl
IHZpYSBLVk1fRVhJVF9IWVBFUlYsIGV4YWN0bHkgYXMNCmZvciBhIG5vbi1uZXN0ZWQgZ3Vl
c3QuDQoNCldoeSB0aGlzIGJlbG9uZ3MgaW4gdGhlIGtlcm5lbA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpUaGUgbWVzc2FnZSBoYW5kbGluZyBhbHJlYWR5IGxpdmVzIGlu
IHVzZXJzcGFjZSBhbmQgZG9lcyBub3QgbW92ZTogYSANCm5vbi1uZXN0ZWQNCkh2UG9zdE1l
c3NhZ2UgZXhpdHMgdG8gdXNlcnNwYWNlIHRvZGF5IHZpYSBLVk1fRVhJVF9IWVBFUlYsIGFu
ZCB0aGUgcmVsYXllZA0KbmVzdGVkIHBvc3QgdGFrZXMgdGhlIHNhbWUgZXhpdC4gT25seSB0
d28gc3RlcHMgY2Fubm90IGJlIGRvbmUgaW4gDQp1c2Vyc3BhY2Ugd2l0aA0KdGhlIGN1cnJl
bnQgdUFQSSwgYW5kIGJvdGggYXJlIGtlcm5lbC1vbmx5IHByaW1pdGl2ZXM6DQoNCiDCoCAx
LiBTdXBwcmVzc2luZyBuZXN0ZWQgZXhpdCByZWZsZWN0aW9uLiBUaGUgImtlZXAgdGhpcyBM
MiBWTUNBTEwgaW4gTDAgDQppbnN0ZWFkDQogwqAgwqAgwqBvZiByZWZsZWN0aW5nIHRvIEwx
IiBkZWNpc2lvbiBpcyBtYWRlIGluIA0KbmVzdGVkX3ZteF9yZWZsZWN0X3ZtZXhpdCgpOyBL
Vk0NCiDCoCDCoCDCoGRvZXMgbm90IGV4aXQgdG8gdXNlcnNwYWNlIG9uIGEgbmVzdGVkIEwy
IFZNLWV4aXQgYmVmb3JlIGRlY2lkaW5nDQogwqAgwqAgwqByZWZsZWN0aW9uLCBhbmQgYWRk
aW5nIHN1Y2ggYW4gZXhpdCB3b3VsZCBiZSBhIG11Y2ggYnJvYWRlciBhbmQgDQpyaXNraWVy
DQogwqAgwqAgwqBBQkkuIEEgbmVzdGVkIGV4aXQgYWxzbyBjYW5ub3QgYmUgY2xlYW5seSBy
ZWZsZWN0ZWQgdG8gTDEgYWZ0ZXIgYSANCnVzZXJzcGFjZQ0KIMKgIMKgIMKgcm91bmQtdHJp
cCwgd2hpY2ggaXMgd2h5IHRoZSBkZWNpc2lvbiBzdGF5cyBpbiB0aGUga2VybmVsLg0KIMKg
IDIuIFRyYW5zbGF0aW5nIHRoZSBMMiBHUEEgdG8gYW4gTDEgR1BBLCB3aGljaCBuZWVkcyB0
aGUgbmVzdGVkIE1NVSAvIA0Kc2hhZG93DQogwqAgwqAgwqBFUFQgdGhhdCB1c2Vyc3BhY2Ug
Y2Fubm90IHdhbGsuDQoNClRoZSByZWxheWFibGUgc2V0IGlzIGEgdXNlcnNwYWNlLXN1cHBs
aWVkIGJpdG1hc2sNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCmFyZ3NbMF0gc2VsZWN0cyB3aGljaCBuZXN0ZWQgSHlwZXItViBoeXBlcmNh
bGwgY2xhc3NlcyB0byBrZWVwIGluIEwwLiBUaGUNCmluLWtlcm5lbCBkZWNpc2lvbiBzdGF5
cyBpbiB0aGUga2VybmVsLCB0aGUgY2hvaWNlIG9mIHdoaWNoIGNhbGxzIHRvIA0KcmVsYXkg
aXMNCnVzZXJzcGFjZSdzLCBhbmQgdGhlIGtlcm5lbCBjYXJyaWVzIG5vIHZtYnVzLXNwZWNp
ZmljIHBvbGljeS4gTmV3IHJlbGF5YWJsZQ0KbmVzdGVkIGh5cGVyY2FsbHMgY2FuIGJlIGFk
ZGVkIHdpdGhvdXQgYW5vdGhlciBrZXJuZWwgY2hhbmdlLg0KDQpTY29wZSBhbmQgbGltaXRh
dGlvbnMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIMKgIC0gVk1YLW9ubHk7IG5vIFNWTSBj
b3VudGVycGFydCB5ZXQuDQogwqAgLSBUaGUgY2FwYWJpbGl0eSBudW1iZXIgMjQ5IGlzIGEg
cGxhY2Vob2xkZXIgcGVuZGluZyBhc3NpZ25tZW50Lg0KIMKgIC0gTm8gc2VsZnRlc3QgeWV0
ICh0aGlzIGlzIGFuIFJGQyBmb3IgZGlyZWN0aW9uKS4gQSBzZWxmdGVzdCBhbmQsIGlmIHRo
ZQ0KIMKgIMKgIHJlbGF5IHN0YXlzLCBhbiBTVk0gcGF0aCB3b3VsZCBjb21lIHdpdGggdGhl
IG5vbi1SRkMgc2VyaWVzLg0KDQpUb29saW5nIHRyYW5zcGFyZW5jeQ0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0NClRoaXMgd29yayB3YXMgZGV2ZWxvcGVkIHdpdGggQUkgYXNzaXN0YW5jZSAo
Q2xhdWRlLCBjbGF1ZGUtb3B1cy00LTgpLCANCnJlZmxlY3RlZA0KaW4gZWFjaCBwYXRjaCdz
IEFzc2lzdGVkLWJ5IHRhZy4gVGhlIGFzc2lzdGFudCBhbmFseXplZCB0aGUgbmVzdGVkLWV4
aXQNCnJlZmxlY3Rpb24gYW5kIEh5cGVyLVYgaHlwZXJjYWxsIHBhdGhzLCBkcmFmdGVkIHRo
ZSBjb21tZW50cyBhbmQgDQpjaGFuZ2Vsb2dzLCBhbmQNCmNyb3NzLWNoZWNrZWQgdGhlIGJl
aGF2aW9yIGFnYWluc3QgdGhlIFRMRlMgYW5kIHRoZSBleGlzdGluZyBMMiBUTEItZmx1c2gN
CmhhbmRsaW5nLiBUaGUgbWVjaGFuaXNtIHdhcyBkZXJpdmVkIGZyb20gcnVudGltZSBhbmFs
eXNpcyBvZiBhIHN0b2NrIFdpbmRvd3MNCmd1ZXN0IHRoYXQgYnVnY2hlY2tzIDB4N0Igd2l0
aG91dCB0aGUgcmVsYXkgYW5kIGJvb3RzIHdpdGggaXQuIFRoZSANCnN1Ym1pdHRlciBoYXMN
CnJldmlld2VkIHRoZSBjaGFuZ2UgaW4gZnVsbCBhbmQgdGFrZXMgcmVzcG9uc2liaWxpdHkg
Zm9yIGl0Lg0KDQpUZXN0aW5nDQotLS0tLS0tDQpUaGUgcmVsYXkgbWVjaGFuaXNtIHdhcyB2
YWxpZGF0ZWQgb24gYSBQcm94bW94IFZFIDcuMC4yIGtlcm5lbCAodGhlIHNhbWUgDQpsb2dp
YywNCmFwcGxpZWQgdG8gdGhhdCB0cmVlKTogYSBzdG9jayBuZXN0ZWQgV2luZG93cyBndWVz
dCB1bmRlciBhIHVzZXJzcGFjZSANClZNTSB0aGF0DQpvd25zIHRoZSBob3N0IHZtYnVzIGVu
ZHBvaW50IGZhaWxzIHRvIGJyaW5nIHVwIGl0cyByb290IHZtYnVzICgweDdCKSANCndpdGhv
dXQgdGhlDQpjYXBhYmlsaXR5IGFuZCBib290cyB0byB0aGUgZnVsbCBkZXNrdG9wIHdpdGgg
aXQuIGNoZWNrcGF0Y2ggaXMgY2xlYW4gb24gDQpib3RoDQpwYXRjaGVzLiBBIG1haW5saW5l
IEtWTV9JTlRFTD1tIEtWTV9BTUQ9bSBLVk1fV0VSUk9SPXkgYnVpbGQgYW5kIGEgS1ZNIA0K
c2VsZnRlc3QNCmFyZSBzdGlsbCB0byBjb21lIHdpdGggdGhlIG5vbi1SRkMgc2VyaWVzLg0K
DQoNCllvdXJzIHNpbmNlcmVseQ0KDQpJbmcuIFJvYmVydCBOb3dvdG55DQpJbmcuIFJvYmVy
dCBOb3dvdG55DQpDVE8sIEV4ZWN1dGl2ZSBUZWNobmljYWwgRGlyZWN0b3INCg0KUm90ZWsg
R21iSCA8aHR0cHM6Ly93d3cucm90ZWsuYXQ+DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKkNvbXBhbnkg
SW5mb3JtYXRpb24gOioNClJvdGVrIEhhbmRlbHMgR21iSA0KSGFuZGVsc3N0cmFzc2UgNA0K
QS0yMjAxIEhhZ2VuYnJ1bm4NCkF1c3RyaWENCg0KVGVsIDogKzQzLTIyNDYtMjA3OTEtMjMN
CkZheCA6ICs0My0yMjQ2LTIwNzkxLTUwDQoNCkV4ZWN1dGl2ZSBEaXJlY3RvcjogUm9iZXJ0
IFJlcm5iw7Zjaw0KUmVnaXN0ZXJlZCB1bmRlciA6IEZOMjcxOTgyeiwgTGFuZGVzZ2VyaWNo
dCBLb3JuZXVidXJnDQpWQVQgTnVtYmVyIDogQVRVNjIxMzkxMzUNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
KkNPTlRBQ1Q6Kg0KbWFpbHRvOiBybm93b3RueUByb3Rlay5hdA0KV2ViOiBodHRwczovL3d3
dy5yb3Rlay5hdA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCg==
--------------wveHTjyskrA3gw5g0Va40neh
Content-Type: multipart/related;
 boundary="------------MfkrPRqhDL9ZfJIaLjjFZhiA"

--------------MfkrPRqhDL9ZfJIaLjjFZhiA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>the patches are small - but not THAT small. forgot to attach
      them, I am sorry.<br>
      Please find the patches attached.<br>
      Robert (aka bitranox)</p>
    <div class=3D"moz-forward-container">-----------------------<br>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <p>This RFC asks for direction on a small KVM/x86 addition before
        adding a selftest<br>
        and an SVM counterpart. It lets a nested Hyper-V root
        partition's vmbus come up<br>
        when the L1 hypervisor runs under KVM with a userspace VMM that
        owns the host<br>
        vmbus endpoint.<br>
        <br>
        Patch 1 renames nested_evmcs_l2_tlb_flush_enabled() to<br>
        nested_evmcs_l2_direct_hypercall_enabled(), since the predicate
        is really "L1<br>
        granted this L2 the eVMCS direct-hypercall facility" and a
        second caller now<br>
        shares it. No functional change.<br>
        <br>
        Patch 2 adds the relay.<br>
        <br>
        The userspace user is OpenVMM (<a class=3D"moz-txt-link-freetext"=

          href=3D"https://github.com/microsoft/openvmm"
          moz-do-not-send=3D"true">https://github.com/microsoft/openvmm</=
a>);
        the<br>
        companion change that enables this capability with the bitmask
        will be posted to<br>
        OpenVMM later.<br>
        <br>
        Problem<br>
        -------<br>
        A Windows guest that enables Hyper-V/VBS runs its own kernel as
        the root<br>
        partition of a nested hypervisor, i.e. as an L2 guest: guest
        kernel -&gt;<br>
        nested hypervisor (L1) -&gt; KVM (L0). The root's vmbus never
        connects. Its<br>
        HvPostMessage(InitiateContact) is an L2 VMCALL that exits to L0
        and is<br>
        reflected up to L1, which has no path to forward it to the
        userspace VMM. The<br>
        guest bugchecks 0x7B early in boot.<br>
        <br>
        What the patch does<br>
        -------------------<br>
        Add a per-VM capability whose argument is a bitmask of the
        nested Hyper-V<br>
        hypercall classes userspace wants kept in L0 (HvPostMessage,
        HvSignalEvent).<br>
        For a selected class, and when L1 has authorized the L2 for
        direct nested<br>
        hypercalls (nested_evmcs_l2_direct_hypercall_enabled(), the gate
        KVM already<br>
        honors for the L2 TLB-flush hypercall), the L2 VMCALL is handled
        in L0 instead<br>
        of reflected to L1: KVM clears the nested bit, translates the L2
        GPA in the<br>
        input parameter to an L1 GPA via the nested MMU, and lets the
        existing<br>
        hypercall path deliver the post to userspace via
        KVM_EXIT_HYPERV, exactly as<br>
        for a non-nested guest.<br>
        <br>
        Why this belongs in the kernel<br>
        ------------------------------<br>
        The message handling already lives in userspace and does not
        move: a non-nested<br>
        HvPostMessage exits to userspace today via KVM_EXIT_HYPERV, and
        the relayed<br>
        nested post takes the same exit. Only two steps cannot be done
        in userspace with<br>
        the current uAPI, and both are kernel-only primitives:<br>
        <br>
        =C2=A0 1. Suppressing nested exit reflection. The "keep this L2
        VMCALL in L0 instead<br>
        =C2=A0 =C2=A0 =C2=A0of reflecting to L1" decision is made in
        nested_vmx_reflect_vmexit(); KVM<br>
        =C2=A0 =C2=A0 =C2=A0does not exit to userspace on a nested L2 VM-=
exit before
        deciding<br>
        =C2=A0 =C2=A0 =C2=A0reflection, and adding such an exit would be =
a much broader
        and riskier<br>
        =C2=A0 =C2=A0 =C2=A0ABI. A nested exit also cannot be cleanly ref=
lected to L1
        after a userspace<br>
        =C2=A0 =C2=A0 =C2=A0round-trip, which is why the decision stays i=
n the kernel.<br>
        =C2=A0 2. Translating the L2 GPA to an L1 GPA, which needs the ne=
sted
        MMU / shadow<br>
        =C2=A0 =C2=A0 =C2=A0EPT that userspace cannot walk.<br>
        <br>
        The relayable set is a userspace-supplied bitmask<br>
        -------------------------------------------------<br>
        args[0] selects which nested Hyper-V hypercall classes to keep
        in L0. The<br>
        in-kernel decision stays in the kernel, the choice of which
        calls to relay is<br>
        userspace's, and the kernel carries no vmbus-specific policy.
        New relayable<br>
        nested hypercalls can be added without another kernel change.<br>=

        <br>
        Scope and limitations<br>
        ---------------------<br>
        =C2=A0 - VMX-only; no SVM counterpart yet.<br>
        =C2=A0 - The capability number 249 is a placeholder pending
        assignment.<br>
        =C2=A0 - No selftest yet (this is an RFC for direction). A selfte=
st
        and, if the<br>
        =C2=A0 =C2=A0 relay stays, an SVM path would come with the non-RF=
C series.<br>
        <br>
        Tooling transparency<br>
        --------------------<br>
        This work was developed with AI assistance (Claude,
        claude-opus-4-8), reflected<br>
        in each patch's Assisted-by tag. The assistant analyzed the
        nested-exit<br>
        reflection and Hyper-V hypercall paths, drafted the comments and
        changelogs, and<br>
        cross-checked the behavior against the TLFS and the existing L2
        TLB-flush<br>
        handling. The mechanism was derived from runtime analysis of a
        stock Windows<br>
        guest that bugchecks 0x7B without the relay and boots with it.
        The submitter has<br>
        reviewed the change in full and takes responsibility for it.<br>
        <br>
        Testing<br>
        -------<br>
        The relay mechanism was validated on a Proxmox VE 7.0.2 kernel
        (the same logic,<br>
        applied to that tree): a stock nested Windows guest under a
        userspace VMM that<br>
        owns the host vmbus endpoint fails to bring up its root vmbus
        (0x7B) without the<br>
        capability and boots to the full desktop with it. checkpatch is
        clean on both<br>
        patches. A mainline KVM_INTEL=3Dm KVM_AMD=3Dm KVM_WERROR=3Dy buil=
d and
        a KVM selftest<br>
        are still to come with the non-RFC series.<br>
        <br>
        <br>
        <font face=3D"Courier New"><span
style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;
        mso-fareast-font-family:&quot;Courier New&quot;;mso-fareast-langu=
age:DE-AT; mso-no-proof:yes">Yours
            sincerely<br>
            <br>
            <img src=3D"cid:part1.QDFd0hlA.PIFDw7dS@rotek.at"
              alt=3D"Ing. Robert Nowotny" class=3D""><br>
            Ing. Robert Nowotny<br>
            <span style=3D"font-size:10.0pt"> CTO, Executive Technical
              Director<br>
              <br>
            </span><span style=3D"font-size:10.0pt"> <a
                href=3D"https://www.rotek.at" moz-do-not-send=3D"true"> <=
img
                  src=3D"cid:part2.TrxyaGCs.KAa25SML@rotek.at"
                  alt=3D"Rotek GmbH" class=3D""></a><br>
            </span> <br>
            <span style=3D"font-size:10.0pt">
------------------------------------------------------------------<br>
              <b>Company Information :</b><br>
              Rotek Handels GmbH<br>
              Handelsstrasse 4<br>
              A-2201 Hagenbrunn<br>
              Austria<br>
              <br>
              Tel : +43-2246-20791-23<br>
              Fax : +43-2246-20791-50<br>
              <br>
              Executive Director: Robert Rernb=C3=B6ck<br>
              Registered under : FN271982z, Landesgericht Korneuburg<br>
              VAT Number : ATU62139135<br>
------------------------------------------------------------------<br>
              <b>CONTACT:</b><br>
              mailto: <a href=3D"mailto:rnowotny@rotek.at"
                class=3D"moz-txt-link-freetext" moz-do-not-send=3D"true">=

                rnowotny@rotek.at</a><br>
              Web: <a href=3D"https://www.rotek.at"
                class=3D"moz-txt-link-freetext" moz-do-not-send=3D"true">=

                https://www.rotek.at</a><br>
------------------------------------------------------------------<br>
            </span></span></font>
        <meta http-equiv=3D"content-type"
          content=3D"text/html; charset=3DUTF-8">
        <br>
      </p>
    </div>
  </body>
</html>
--------------MfkrPRqhDL9ZfJIaLjjFZhiA
Content-Type: image/jpeg; name="xybJEaKlPIe8gd8s.jpg"
Content-Disposition: inline; filename="xybJEaKlPIe8gd8s.jpg"
Content-Id: <part1.QDFd0hlA.PIFDw7dS@rotek.at>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAATsAAAB+CAQAAADxN34nAAAACXBIWXMAAC4jAAAuIwF4pT92
AAALSWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlk
PSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9i
ZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDIgNzkuMTYwOTI0
LCAyMDE3LzA3LzEzLTAxOjA2OjM5ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0
dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2Ny
aXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFw
LzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1s
bnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxu
czp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9
Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1s
bnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJl
ZiMiIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIiB4bXA6Q3Jl
YXRlRGF0ZT0iMjAyMC0wNi0xNFQyMzoxNjozMyswMjowMCIgeG1wOk1vZGlmeURhdGU9IjIw
MjUtMDEtMjJUMTA6NDc6MDYrMDE6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMjUtMDEtMjJU
MTA6NDc6MDYrMDE6MDAiIGRjOmZvcm1hdD0iaW1hZ2UvcG5nIiBwaG90b3Nob3A6Q29sb3JN
b2RlPSIxIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0iR3JheSBHYW1tYSAyLjIiIHhtcE1NOklu
c3RhbmNlSUQ9InhtcC5paWQ6YjBmNGVhY2MtYzYzZC03MjRjLWFmYjAtOTBjYWExNWM2OWQ2
IiB4bXBNTTpEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6MGY5NzMwMGMtYzA0
Yi01MTRhLThjNzgtYmI4YzViMzE1YmE1IiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9Inht
cC5kaWQ6ZTkyYzEyYjUtZTA4OC1mYTRhLWE5OTItYjk3M2IzMzE0YWJiIiB0aWZmOkltYWdl
V2lkdGg9Ijc4OSIgdGlmZjpJbWFnZUxlbmd0aD0iMzE1IiB0aWZmOkNvbXByZXNzaW9uPSIz
Mjc3MyIgdGlmZjpQaG90b21ldHJpY0ludGVycHJldGF0aW9uPSIxIiB0aWZmOlNhbXBsZXNQ
ZXJQaXhlbD0iMSIgdGlmZjpQbGFuYXJDb25maWd1cmF0aW9uPSIxIiB0aWZmOlhSZXNvbHV0
aW9uPSIzMDAvMSIgdGlmZjpZUmVzb2x1dGlvbj0iMzAwLzEiIHRpZmY6UmVzb2x1dGlvblVu
aXQ9IjIiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9u
PSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmU5MmMxMmI1LWUwODgtZmE0
YS1hOTkyLWI5NzNiMzMxNGFiYiIgc3RFdnQ6d2hlbj0iMjAyMC0wNi0xNFQyMzoxNjozMysw
MjowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dz
KSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9Inht
cC5paWQ6NDc2Mzk3YzQtYzlhYy03NzRmLThmNjktNzYwN2I5YzliNjBmIiBzdEV2dDp3aGVu
PSIyMDIxLTA0LTE2VDE3OjUxOjE2KzAyOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9i
ZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIiBzdEV2dDpjaGFuZ2VkPSIvIi8+IDxyZGY6bGkg
c3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo0NWM5M2Uy
ZC05MWY1LTFkNDktOGEyMC05NGI0Yjk1NmUzNDEiIHN0RXZ0OndoZW49IjIwMjEtMDQtMTZU
MTc6NTI6MDUrMDI6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBD
QyAoV2luZG93cykiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249
ImNvbnZlcnRlZCIgc3RFdnQ6cGFyYW1ldGVycz0iZnJvbSBpbWFnZS90aWZmIHRvIGltYWdl
L3BuZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iZGVyaXZlZCIgc3RFdnQ6cGFyYW1ldGVy
cz0iY29udmVydGVkIGZyb20gaW1hZ2UvdGlmZiB0byBpbWFnZS9wbmciLz4gPHJkZjpsaSBz
dEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjU0ZWNmMWRh
LWIyZGMtNDk0YS04MzY4LWNmNDQ2Yzk1YzU2MCIgc3RFdnQ6d2hlbj0iMjAyMS0wNC0xNlQx
Nzo1MjowNSswMjowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIEND
IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0i
c2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6YjBmNGVhY2MtYzYzZC03MjRjLWFm
YjAtOTBjYWExNWM2OWQ2IiBzdEV2dDp3aGVuPSIyMDI1LTAxLTIyVDEwOjQ3OjA2KzAxOjAw
IiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIiBz
dEV2dDpjaGFuZ2VkPSIvIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8eG1wTU06
RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0NWM5M2UyZC05MWY1LTFk
NDktOGEyMC05NGI0Yjk1NmUzNDEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6ZTkyYzEy
YjUtZTA4OC1mYTRhLWE5OTItYjk3M2IzMzE0YWJiIiBzdFJlZjpvcmlnaW5hbERvY3VtZW50
SUQ9InhtcC5kaWQ6ZTkyYzEyYjUtZTA4OC1mYTRhLWE5OTItYjk3M2IzMzE0YWJiIi8+IDx0
aWZmOkJpdHNQZXJTYW1wbGU+IDxyZGY6U2VxPiA8cmRmOmxpPjE8L3JkZjpsaT4gPC9yZGY6
U2VxPiA8L3RpZmY6Qml0c1BlclNhbXBsZT4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJE
Rj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6d9IklAAAZXElEQVR4nO2deWBV
xfXHPwmYshhANsGFguC+UZdCBBRKUVGLiEXr8tPWYqziUrXutmpda63iitGqaBW07qKiUrSi
guIuiqDIrsbIGtkhOb8/Zu68uft9Ly8vNrnf+0fy7sydOffe753lnDNnioQUKQqN4oYWIEVT
REq7FA2AlHYpGgAp7VI0AJrbP4oaSooU9YUt+Q3DaQ+M546GFUXcPzJHikaF/biLb6zXO4F+
DSmOi2kp7RopLnO9WnVU0rPhBLIFKbLJlnayjQZ/5Bb933y+BUDoB8xmbzY2jEhpJ9u40Yxz
9Qu9nodpac5fhSA82lBipZ1s48YJ+nXO9qUMRBDaNIBMpLRr3OjIpwjC9+wakHo9wtiCywSk
tGvceFmTrltgaseGe9Ep7Rovdtev8nehOT5mcwHlsZDSrvHiSQRhWoRS4hGEnxVQIgObaalx
rDFhO4YA33NgaBtSQgdgrwLKFIiUdo0Jf6UUeDKiG21GW2BZwSQKQ9rJNhoU8R1CLQdE5hqH
MK4wArmRdrKNE4fTGZjFtMhcLaGh7BQZpLRrPNgBWMefYnKtgRDlSgGR0q7xoDewhpci85TQ
DXijEOJEIh3bNRJ0ZRXCD24PSh/aIAi/LJBMLqRju8aI3rQBTo9RBivCdSyAPNFIW7tGgt4I
H8Xmugyhkvb1L44faWvXGHEoaM+6KLQD1rC8voWJQ0q7xoK+wE9icx0ODdPWuZHSrjHB72Hn
RWvgnfoXJA7R8x4/OjGMZsDnP4JJeAobb3MkP43JcxrdgH8WQpwYZDGlOJqPWWsy31cI6VIk
xn4IU2PyvIuwgnaFEMeP3ByfHnBlFYSXCyNuikToj/CfyBwdkNg89Yjsabcvb/hIJwinF07o
FDFoRiUr2DIix0MIwuMFk8iDbGl3Autc2SYz1ZwpKaTgKSJxM8JvQlNbswnhB3YvoEQuZEe7
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
D/L8rLCuCxHLAAAAAElFTkSuQmCC
--------------MfkrPRqhDL9ZfJIaLjjFZhiA
Content-Type: image/png; name="uPPOdcZtOgplBxIt.png"
Content-Disposition: inline; filename="uPPOdcZtOgplBxIt.png"
Content-Id: <part2.TrxyaGCs.KAa25SML@rotek.at>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAASwAAAA6CAYAAAAKhWRHAAABS2lUWHRYTUw6Y29tLmFkb2Jl
LnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRj
emtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0i
QWRvYmUgWE1QIENvcmUgNS42LWMxNDIgNzkuMTYwOTI0LCAyMDE3LzA3LzEzLTAxOjA2OjM5
ICAgICAgICAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5
LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0i
Ii8+CiA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgo8P3hwYWNrZXQgZW5kPSJyIj8+nhxg7wAA
IABJREFUeJzsfXd4FNe99ntmZmf7aot6QUISSIgOBgM2xWCDewPHuDtxsOPcOHbKvU5uvsSJ
E8dOdew4iR33XsE4GFwDtulFEhKiqddV26KtMzvtfH+sJFO0kgABcq7f5+F5gJ1z5kx7z6//
yP/+vwduAGABEMNXDJIUYwsKCiSPx+t/5flnAz/5+QOdbre72ePpltLS0pGbm4uuri5QSlFU
VAQdxwEE+OKLLzB79mxcdskyBIJBUEr75zzir9DpOPT0BBCLxbD/wEF4vV7k5+ejpqYGqamp
MBqN2Lp1qzMajZ5HNTq1vd2dV19bMzkzK3taR3u7EgmFtFAwcMbuB6/Xw+50QlM1WGw2OJ1O
k6pqbdUH9++Zt3BRSBSEDk93d9OcefN6YrEYd+S1fo2zCh0hUBRZWW0wGsLZ2TkghOhbW1uX
C9GomeW4/m9TEKLm9PSM9nPPnb1WlmVomnZSJySEgGVZRKMC2traYLPZYLFYAABmswkcx2Hf
virEYjHwPA+j0QiGITCZzDCZTNA0FRaLBUk2G+obGtDQ0Aiz2Qyz2QRCGHAcB5vNCkop9HoD
rFYLHA47tm3bnl1XV3cZpZBYllUHWhvLMEokGnF2dXYVL1i44PV5c+duDUcioJSCe/PlF58C
YD2pqx5FIAyDPz78EHi9PmSx2uqdycmV3V1d2+0Ox/rs7Ozm1NRkhMMRSJKEE/1QKQVUVYPe
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
YII=

--------------MfkrPRqhDL9ZfJIaLjjFZhiA--


--------------wveHTjyskrA3gw5g0Va40neh--

--------------oAkJlQkyexkkEkFyf80JxdBZ
Content-Type: text/plain; charset=UTF-8;
 name="0002-KVM-x86-Relay-a-nested-Hyper-V-root-s-vmbus-posts-to.patch"
Content-Disposition: attachment;
 filename*0="0002-KVM-x86-Relay-a-nested-Hyper-V-root-s-vmbus-posts-to.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwNjk2N2M5Y2YzNDJlOGYzYTk0MGUyN2Y4ZmFhNDJiOWE5OWExZDkwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBiaXRyYW5veCA8cm5vd290bnkxOTY2QGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAxNyBKdW4gMjAyNiAxNDo0NTo1NSArMDIwMApTdWJqZWN0OiBbUkZD
IFBBVENIIDIvMl0gS1ZNOiB4ODY6IFJlbGF5IGEgbmVzdGVkIEh5cGVyLVYgcm9vdCdzIHZt
YnVzIHBvc3RzCiB0byBMMAoKQWRkIEtWTV9DQVBfTkVTVEVEX0hZUEVSVl9IQ0FMTF9SRUxB
WSwgYSBwZXItVk0gY2FwYWJpbGl0eSB3aG9zZSBhcmd1bWVudApzZWxlY3RzIHdoaWNoIG9m
IGEgbmVzdGVkIEh5cGVyLVYgcm9vdCBwYXJ0aXRpb24ncyBlbmxpZ2h0ZW5lZCBoeXBlcmNh
bGxzCihIdlBvc3RNZXNzYWdlLCBIdlNpZ25hbEV2ZW50KSBLVk0ga2VlcHMgaW4gTDAgaW5z
dGVhZCBvZiByZWZsZWN0aW5nIHRvCkwxLgoKQSBXaW5kb3dzIGd1ZXN0IHRoYXQgZW5hYmxl
cyBIeXBlci1WL1ZCUyBydW5zIGl0cyBvd24ga2VybmVsIGFzIHRoZSByb290CnBhcnRpdGlv
biBvZiB0aGUgbmVzdGVkIGh5cGVydmlzb3IsIGkuZS4gYXMgYW4gTDIgZ3Vlc3Q6IGd1ZXN0
IGtlcm5lbCAtPgpuZXN0ZWQgaHlwZXJ2aXNvciAoTDEpIC0+IEtWTSAoTDApLiBUaGF0IHJv
b3QncyB2bWJ1cyBuZXZlciBjb25uZWN0cywKYmVjYXVzZSBpdHMgSHZQb3N0TWVzc2FnZShJ
bml0aWF0ZUNvbnRhY3QpIGlzIGFuIEwyIFZNQ0FMTCB0aGF0IGV4aXRzIHRvCkwwIGFuZCBp
cyByZWZsZWN0ZWQgdXAgdG8gTDEsIHdoaWNoIGhhcyBubyBwYXRoIHRvIGZvcndhcmQgaXQg
ZG93biB0byB0aGUKdXNlcnNwYWNlIFZNTS4gVGhlIGd1ZXN0IGJ1Z2NoZWNrcyAweDdCIGFu
ZCBwb3dlcnMgb2ZmIGVhcmx5IGluIGJvb3QuCgpGb3IgYSBjYWxsIGNsYXNzIHVzZXJzcGFj
ZSBzZWxlY3RlZCwgYW5kIHdoZW4gTDEgaGFzIGF1dGhvcml6ZWQgdGhpcyBMMgpmb3IgZGly
ZWN0IG5lc3RlZCBoeXBlcmNhbGxzIChuZXN0ZWRfZXZtY3NfbDJfZGlyZWN0X2h5cGVyY2Fs
bF9lbmFibGVkKCksCnRoZSBzYW1lIGVWTUNTIGdhdGUgS1ZNIGFscmVhZHkgdHJ1c3RzIGZv
ciB0aGUgTDIgVExCLWZsdXNoIGh5cGVyY2FsbCksCmhhbmRsZSB0aGUgTDIgVk1DQUxMIGlu
IEwwIGluc3RlYWQgb2YgcmVmbGVjdGluZyBpdDogY2xlYXIgdGhlIG5lc3RlZCBiaXQKc28g
a3ZtX2h2X2h5cGVyY2FsbCgpIGFjY2VwdHMgdGhlIGNhbGwsIHRoZW4gbGV0IHRoZSBleGlz
dGluZyBoeXBlcmNhbGwKcGF0aCBkZWxpdmVyIGl0IHRvIHVzZXJzcGFjZSB2aWEgS1ZNX0VY
SVRfSFlQRVJWLCBleGFjdGx5IGFzIGZvciBhCm5vbi1uZXN0ZWQgZ3Vlc3QuIEFuIEwyIHRo
YXQgTDEgZGlkIG5vdCBhdXRob3JpemUgKGEgZ3JhbmRjaGlsZCBvZiB0aGUKcm9vdCkgaXMg
bmV2ZXIgcmVsYXllZCBhbmQga2VlcHMgaXRzIG93biBMMSBzeW5pYy4KClRoZSByZWxheWVk
IHBvc3QgY2FycmllcyBhbiBMMiBHUEEgaW4gaXRzIGlucHV0IHBhcmFtZXRlci4gVHJhbnNs
YXRlIGl0CnRvIGFuIEwxIEdQQSBpbiBrdm1faHZfaHlwZXJjYWxsKCkgZm9yIHRoZSBzbG93
IEh2UG9zdE1lc3NhZ2UgYW5kCkh2U2lnbmFsRXZlbnQgcGF0aHMsIHRoZSBzYW1lIHdheSB0
aGUgTDIgVExCLWZsdXNoIHNsb3cgcGF0aCBhbHJlYWR5CmRvZXM7IHRoZSB3YWxrIGFsc28g
cmVqZWN0cyBwYWdlcyByZW1vdmVkIGZyb20gdGhlIEwyIHJvb3QncyBHUEEgc3BhY2UuClRo
ZSB0cmFuc2xhdGlvbiBydW5zIHN5bmNocm9ub3VzbHkgaW4gdGhlIGZhdWx0aW5nIHZDUFUn
cyBleGl0IGNvbnRleHQKYW5kIGlzIG5vdCBjYWNoZWQgYWNyb3NzIHRoZSB1c2Vyc3BhY2Ug
ZXhpdC4KClRoZSByZWxheSBpcyBWTVgtb25seTsgdGhlcmUgaXMgbm8gU1ZNIGNvdW50ZXJw
YXJ0IHlldC4KCkFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC04ClNpZ25lZC1v
ZmYtYnk6IGJpdHJhbm94IDxybm93b3RueTE5NjZAZ21haWwuY29tPgotLS0KIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAgMiArKwogYXJjaC94ODYvaW5jbHVkZS91YXBp
L2FzbS9rdm0uaCB8ICA0ICsrKysKIGFyY2gveDg2L2t2bS9oeXBlcnYuYyAgICAgICAgICAg
fCAyMCArKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jICAg
ICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9r
dm0veDg2LmMgICAgICAgICAgICAgIHwgIDggKysrKysrKysKIGluY2x1ZGUvdWFwaS9saW51
eC9rdm0uaCAgICAgICAgfCAgMSArCiA2IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCAzODg2YjUzNmM4YTUuLjE4NzZl
YmE0YjQzYiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xNDM1LDYgKzE0MzUs
OCBAQCBlbnVtIGt2bV9tbXVfdHlwZSB7CiB9OwogCiBzdHJ1Y3Qga3ZtX2FyY2ggeworCS8q
IFJlbGF5YWJsZSBuZXN0ZWQgSHlwZXItViBoeXBlcmNhbGxzIChLVk1fQ0FQX05FU1RFRF9I
WVBFUlZfSENBTExfUkVMQVkpLiAqLworCXU2NCBuZXN0ZWRfaHZfcmVsYXlfbWFzazsKIAl1
bnNpZ25lZCBsb25nIG5fdXNlZF9tbXVfcGFnZXM7CiAJdW5zaWduZWQgbG9uZyBuX3JlcXVl
c3RlZF9tbXVfcGFnZXM7CiAJdW5zaWduZWQgbG9uZyBuX21heF9tbXVfcGFnZXM7CmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oIGIvYXJjaC94ODYvaW5j
bHVkZS91YXBpL2FzbS9rdm0uaAppbmRleCAxNTg1ZWM4MDQwNjYuLmNhMTZhNGJjMTMwNiAx
MDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm0uaAorKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oCkBAIC05NjcsNiArOTY3LDEwIEBAIHN0cnVj
dCBrdm1faHlwZXJ2X2V2ZW50ZmQgewogLyogeDg2LXNwZWNpZmljIEtWTV9FWElUX0hZUEVS
Q0FMTCBmbGFncy4gKi8KICNkZWZpbmUgS1ZNX0VYSVRfSFlQRVJDQUxMX0xPTkdfTU9ERQlf
QklUVUxMKDApCiAKKy8qIFJlbGF5YWJsZSBuZXN0ZWQgSHlwZXItViBoeXBlcmNhbGxzIGZv
ciBLVk1fQ0FQX05FU1RFRF9IWVBFUlZfSENBTExfUkVMQVkuICovCisjZGVmaW5lIEtWTV9O
RVNURURfSFlQRVJWX1JFTEFZX1BPU1RfTUVTU0FHRQlfQklUVUxMKDApCisjZGVmaW5lIEtW
TV9ORVNURURfSFlQRVJWX1JFTEFZX1NJR05BTF9FVkVOVAlfQklUVUxMKDEpCisKICNkZWZp
bmUgS1ZNX1g4Nl9ERUZBVUxUX1ZNCTAKICNkZWZpbmUgS1ZNX1g4Nl9TV19QUk9URUNURURf
Vk0JMQogI2RlZmluZSBLVk1fWDg2X1NFVl9WTQkJMgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL2h5cGVydi5jIGIvYXJjaC94ODYva3ZtL2h5cGVydi5jCmluZGV4IGZkNGViMWU1NjFm
Ny4uMjUyY2JkMTRmNjNmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vaHlwZXJ2LmMKKysr
IGIvYXJjaC94ODYva3ZtL2h5cGVydi5jCkBAIC0yNTkxLDYgKzI1OTEsMjYgQEAgaW50IGt2
bV9odl9oeXBlcmNhbGwoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogCQlrdm1faHZfaHlwZXJj
YWxsX3JlYWRfeG1tKCZoYyk7CiAJfQogCisJLyoKKwkgKiBBIHJlbGF5ZWQgbmVzdGVkIEh5
cGVyLVYgcm9vdCdzIEh2UG9zdE1lc3NhZ2UvSHZTaWduYWxFdmVudCAoc2VlCisJICogbmVz
dGVkX3ZteF9yZWZsZWN0X3ZtZXhpdCgpKSBydW5zIG9uIG5lc3RlZCBFUFQgYW5kIGNhcnJp
ZXMgYW4gTDIgR1BBCisJICogaW4gaW5ncGEuICBUcmFuc2xhdGUgaXQgdG8gYW4gTDEgR1BB
LCBtaXJyb3JpbmcgdGhlIEwyIFRMQi1mbHVzaCBzbG93CisJICogcGF0aCBhbmQgZ2F0aW5n
IG9uIG1tdV9pc19uZXN0ZWQoKTogdHJhbnNsYXRlX25lc3RlZF9ncGEoKSByZXF1aXJlcyBh
bgorCSAqIGFjdGl2ZSBuZXN0ZWQgTU1VLCBhbmQgd2l0aCBzaGFkb3cgcGFnaW5nIHRoZSBM
MiBHUEEgaXMgYWxyZWFkeSBhbiBMMQorCSAqIEdQQS4gIFRoZSB3YWxrIHJlamVjdHMgcGFn
ZXMgcmVtb3ZlZCBmcm9tIHRoZSBMMiByb290J3MgR1BBIHNwYWNlCisJICogKElOVkFMSURf
R1BBKS4gIEl0IHJ1bnMgc3luY2hyb25vdXNseSBpbiB0aGUgZmF1bHRpbmcgdkNQVSdzIGV4
aXQKKwkgKiBjb250ZXh0IGFuZCBpcyBub3QgY2FjaGVkLgorCSAqLworCWlmICh2Y3B1LT5r
dm0tPmFyY2gubmVzdGVkX2h2X3JlbGF5X21hc2sgJiYgIWhjLmZhc3QgJiYgbW11X2lzX25l
c3RlZCh2Y3B1KSAmJgorCSAgICAoaGMuY29kZSA9PSBIVkNBTExfUE9TVF9NRVNTQUdFIHx8
IGhjLmNvZGUgPT0gSFZDQUxMX1NJR05BTF9FVkVOVCkpIHsKKwkJaGMuaW5ncGEgPSBrdm1f
eDg2X29wcy5uZXN0ZWRfb3BzLT50cmFuc2xhdGVfbmVzdGVkX2dwYSgKKwkJCQl2Y3B1LCBo
Yy5pbmdwYSwgUEZFUlJfR1VFU1RfRklOQUxfTUFTSywgTlVMTCwgMCk7CisJCWlmICh1bmxp
a2VseShoYy5pbmdwYSA9PSBJTlZBTElEX0dQQSkpIHsKKwkJCXJldCA9IEhWX1NUQVRVU19J
TlZBTElEX0hZUEVSQ0FMTF9JTlBVVDsKKwkJCWdvdG8gaHlwZXJjYWxsX2NvbXBsZXRlOwor
CQl9CisJfQorCiAJc3dpdGNoIChoYy5jb2RlKSB7CiAJY2FzZSBIVkNBTExfTk9USUZZX0xP
TkdfU1BJTl9XQUlUOgogCQlpZiAodW5saWtlbHkoaGMucmVwIHx8IGhjLnZhcl9jbnQpKSB7
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jIGIvYXJjaC94ODYva3Zt
L3ZteC9uZXN0ZWQuYwppbmRleCAyMTc1MmQzYTUxNGEuLjc3YWVjNmQzNmQ3YSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYworKysgYi9hcmNoL3g4Ni9rdm0vdm14
L25lc3RlZC5jCkBAIC02NzI4LDYgKzY3MjgsNDEgQEAgYm9vbCBuZXN0ZWRfdm14X3JlZmxl
Y3Rfdm1leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAogCXRyYWNlX2t2bV9uZXN0ZWRf
dm1leGl0KHZjcHUsIEtWTV9JU0FfVk1YKTsKIAorCS8qCisJICogUmVsYXkgYSBuZXN0ZWQg
SHlwZXItViByb290IHBhcnRpdGlvbidzIGVubGlnaHRlbmVkIHN5bmljIHBvc3RzIHRvIEww
CisJICogcmF0aGVyIHRoYW4gcmVmbGVjdGluZyB0aGVtIHRvIEwxLiAgQSBXaW5kb3dzIGd1
ZXN0IHRoYXQgZW5hYmxlcworCSAqIEh5cGVyLVYvVkJTIHJ1bnMgaXRzIGtlcm5lbCBhcyB0
aGUgcm9vdCBwYXJ0aXRpb24gb2YgYSBuZXN0ZWQKKwkgKiBoeXBlcnZpc29yIChhbiBMMiBn
dWVzdCksIHdob3NlIEh2UG9zdE1lc3NhZ2UvSHZTaWduYWxFdmVudCBWTUNBTExzCisJICog
d291bGQgb3RoZXJ3aXNlIGJlIHJlZmxlY3RlZCB0byBMMSwgd2hpY2ggaGFzIG5vIHBhdGgg
dG8gZm9yd2FyZCB0aGVtCisJICogdG8gdGhlIHVzZXJzcGFjZSBWTU0uICBXaGVuIHVzZXJz
cGFjZSBzZWxlY3RlZCB0aGUgY2FsbCBjbGFzcyB2aWEKKwkgKiBLVk1fQ0FQX05FU1RFRF9I
WVBFUlZfSENBTExfUkVMQVkgYW5kIEwxIGF1dGhvcml6ZWQgdGhpcyBMMiBmb3IgZGlyZWN0
CisJICogbmVzdGVkIGh5cGVyY2FsbHMgKHRoZSBzYW1lIGVWTUNTIGdhdGUgaG9ub3JlZCBm
b3IgdGhlIEwyIFRMQi1mbHVzaAorCSAqIGh5cGVyY2FsbCksIGhhbmRsZSB0aGUgcG9zdCBp
biBMMDogY2xlYXIgdGhlIG5lc3RlZCBiaXQgc28gdGhlIHN0YW5kYXJkCisJICogaHlwZXJj
YWxsIHBhdGggYWNjZXB0cyB0aGUgY2FsbCwgYW5kIHJldHVybiBmYWxzZSB0byBrZWVwIHRo
ZSBleGl0IGluCisJICogTDAuICBBbiBMMiB0aGF0IEwxIGRpZCBub3QgYXV0aG9yaXplIChh
IGdyYW5kY2hpbGQgb2YgdGhlIHJvb3QpIGlzCisJICogbmV2ZXIgcmVsYXllZCBhbmQga2Vl
cHMgaXRzIG93biBMMSBzeW5pYy4KKwkgKi8KKwlpZiAodmNwdS0+a3ZtLT5hcmNoLm5lc3Rl
ZF9odl9yZWxheV9tYXNrICYmCisJICAgIGV4aXRfcmVhc29uLmJhc2ljID09IEVYSVRfUkVB
U09OX1ZNQ0FMTCAmJgorCSAgICBuZXN0ZWRfZXZtY3NfbDJfZGlyZWN0X2h5cGVyY2FsbF9l
bmFibGVkKHZjcHUpKSB7CisJCXU2NCBtYXNrID0gdmNwdS0+a3ZtLT5hcmNoLm5lc3RlZF9o
dl9yZWxheV9tYXNrOworCQl1NjQgaW5wdXQgPSBrdm1fcmN4X3JlYWQodmNwdSk7CisJCXUx
NiBjb2RlID0gaW5wdXQgJiAweGZmZmY7CisJCWJvb2wgcmVsYXkgPSBmYWxzZTsKKworCQlp
ZiAoaW5wdXQgJiBIVl9IWVBFUkNBTExfTkVTVEVEKSB7CisJCQlpZiAoY29kZSA9PSBIVkNB
TExfUE9TVF9NRVNTQUdFKQorCQkJCXJlbGF5ID0gbWFzayAmIEtWTV9ORVNURURfSFlQRVJW
X1JFTEFZX1BPU1RfTUVTU0FHRTsKKwkJCWVsc2UgaWYgKGNvZGUgPT0gSFZDQUxMX1NJR05B
TF9FVkVOVCkKKwkJCQlyZWxheSA9IG1hc2sgJiBLVk1fTkVTVEVEX0hZUEVSVl9SRUxBWV9T
SUdOQUxfRVZFTlQ7CisJCX0KKworCQlpZiAocmVsYXkpIHsKKwkJCWt2bV9yY3hfd3JpdGUo
dmNwdSwgaW5wdXQgJiB+SFZfSFlQRVJDQUxMX05FU1RFRCk7CisJCQlyZXR1cm4gZmFsc2U7
CisJCX0KKwl9CisKIAkvKiBJZiBMMCAoS1ZNKSB3YW50cyB0aGUgZXhpdCwgaXQgdHJ1bXBz
IEwxJ3MgZGVzaXJlcy4gKi8KIAlpZiAobmVzdGVkX3ZteF9sMF93YW50c19leGl0KHZjcHUs
IGV4aXRfcmVhc29uKSkKIAkJcmV0dXJuIGZhbHNlOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IGNmMTIyYjhjMzIxMC4uM2Y3
MTk5Y2RlODg2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94
ODYva3ZtL3g4Ni5jCkBAIC02NzMwLDYgKzY3MzAsMTQgQEAgaW50IGt2bV92bV9pb2N0bF9l
bmFibGVfY2FwKHN0cnVjdCBrdm0gKmt2bSwKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlzd2l0
Y2ggKGNhcC0+Y2FwKSB7CisJY2FzZSBLVk1fQ0FQX05FU1RFRF9IWVBFUlZfSENBTExfUkVM
QVk6CisJCXIgPSAtRUlOVkFMOworCQlpZiAoY2FwLT5hcmdzWzBdICYgfihLVk1fTkVTVEVE
X0hZUEVSVl9SRUxBWV9QT1NUX01FU1NBR0UgfAorCQkJCSAgICAgS1ZNX05FU1RFRF9IWVBF
UlZfUkVMQVlfU0lHTkFMX0VWRU5UKSkKKwkJCWJyZWFrOworCQlrdm0tPmFyY2gubmVzdGVk
X2h2X3JlbGF5X21hc2sgPSBjYXAtPmFyZ3NbMF07CisJCXIgPSAwOworCQlicmVhazsKIAlj
YXNlIEtWTV9DQVBfRElTQUJMRV9RVUlSS1MyOgogCQlyID0gLUVJTlZBTDsKIAkJaWYgKGNh
cC0+YXJnc1swXSAmIH5rdm1fY2Fwcy5zdXBwb3J0ZWRfcXVpcmtzKQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oCmlu
ZGV4IDZjOGFmYTIwNDdiZi4uOWM5NDI3NDkwNDQwIDEwMDY0NAotLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgva3ZtLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oCkBAIC05OTYs
NiArOTk2LDcgQEAgc3RydWN0IGt2bV9lbmFibGVfY2FwIHsKICNkZWZpbmUgS1ZNX0NBUF9T
MzkwX1VTRVJfT1BFUkVYRUMgMjQ2CiAjZGVmaW5lIEtWTV9DQVBfUzM5MF9LRVlPUCAyNDcK
ICNkZWZpbmUgS1ZNX0NBUF9TMzkwX1ZTSUVfRVNBTU9ERSAyNDgKKyNkZWZpbmUgS1ZNX0NB
UF9ORVNURURfSFlQRVJWX0hDQUxMX1JFTEFZIDI0OQogCiBzdHJ1Y3Qga3ZtX2lycV9yb3V0
aW5nX2lycWNoaXAgewogCV9fdTMyIGlycWNoaXA7Ci0tIAoyLjUzLjAKCg==
--------------oAkJlQkyexkkEkFyf80JxdBZ
Content-Type: text/plain; charset=UTF-8;
 name="0001-KVM-VMX-Rename-nested_evmcs_l2_tlb_flush_enabled-to-.patch"
Content-Disposition: attachment;
 filename*0="0001-KVM-VMX-Rename-nested_evmcs_l2_tlb_flush_enabled-to-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNjQ1MzM1M2FhOWNjOWU3MWQ4ZTI2YWRkMjY0MDcwOThlNmU2ODZiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBiaXRyYW5veCA8cm5vd290bnkxOTY2QGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAxNyBKdW4gMjAyNiAxNDo0MjowMSArMDIwMApTdWJqZWN0OiBbUkZD
IFBBVENIIDEvMl0gS1ZNOiBWTVg6IFJlbmFtZSBuZXN0ZWRfZXZtY3NfbDJfdGxiX2ZsdXNo
X2VuYWJsZWQoKQogdG8gcmVmbGVjdCBpdHMgc2NvcGUKClRoZSBwcmVkaWNhdGUgY2hlY2tz
IHdoZXRoZXIgTDEgZ3JhbnRlZCB0aGUgTDIgdGhlIGVubGlnaHRlbmVkLVZNQ1MKZGlyZWN0
IGh5cGVyY2FsbCBmYWNpbGl0eSAobmVzdGVkX2ZsdXNoX2h5cGVyY2FsbCBwbHVzIHRoZSBW
UC1hc3Npc3QKZGlyZWN0aHlwZXJjYWxsIGZlYXR1cmUpLCB3aGljaCBIeXBlci1WIHVzZXMg
Zm9yIG1vcmUgdGhhbiB0aGUgTDIKVExCLWZsdXNoIGh5cGVyY2FsbC4gUmVuYW1lIGl0IHRv
Cm5lc3RlZF9ldm1jc19sMl9kaXJlY3RfaHlwZXJjYWxsX2VuYWJsZWQoKSBzbyBhIHNlY29u
ZCBjYWxsZXIgY2FuIHNoYXJlCml0IHdpdGhvdXQgdGhlIG1pc2xlYWRpbmcgdGxiX2ZsdXNo
IG5hbWUuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlLgoKQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1
ZGUtb3B1cy00LTgKU2lnbmVkLW9mZi1ieTogYml0cmFub3ggPHJub3dvdG55MTk2NkBnbWFp
bC5jb20+Ci0tLQogYXJjaC94ODYva3ZtL3ZteC9oeXBlcnYuYyB8IDIgKy0KIGFyY2gveDg2
L2t2bS92bXgvaHlwZXJ2LmggfCAyICstCiBhcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jIHwg
NCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L2h5cGVydi5jIGIvYXJjaC94ODYv
a3ZtL3ZteC9oeXBlcnYuYwppbmRleCBmYTQxZDAzNmFjZDQuLjdkMGY3OGQ5YWZmNyAxMDA2
NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC9oeXBlcnYuYworKysgYi9hcmNoL3g4Ni9rdm0v
dm14L2h5cGVydi5jCkBAIC0yMDksNyArMjA5LDcgQEAgaW50IG5lc3RlZF9lbmFibGVfZXZt
Y3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCXJldHVybiAwOwogfQogCi1ib29sIG5lc3Rl
ZF9ldm1jc19sMl90bGJfZmx1c2hfZW5hYmxlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiti
b29sIG5lc3RlZF9ldm1jc19sMl9kaXJlY3RfaHlwZXJjYWxsX2VuYWJsZWQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1KQogewogCXN0cnVjdCBrdm1fdmNwdV9odiAqaHZfdmNwdSA9IHRvX2h2
X3ZjcHUodmNwdSk7CiAJc3RydWN0IHZjcHVfdm14ICp2bXggPSB0b192bXgodmNwdSk7CmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L2h5cGVydi5oIGIvYXJjaC94ODYva3ZtL3Zt
eC9oeXBlcnYuaAppbmRleCAxMWEzMzkwMDk3ODEuLjg3MjEwMDExY2FlMyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYva3ZtL3ZteC9oeXBlcnYuaAorKysgYi9hcmNoL3g4Ni9rdm0vdm14L2h5
cGVydi5oCkBAIC01OCw3ICs1OCw3IEBAIGludCBuZXN0ZWRfZW5hYmxlX2V2bWNzKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwKIAkJCXVpbnQxNl90ICp2bWNzX3ZlcnNpb24pOwogdm9pZCBu
ZXN0ZWRfZXZtY3NfZmlsdGVyX2NvbnRyb2xfbXNyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
dTMyIG1zcl9pbmRleCwgdTY0ICpwZGF0YSk7CiBpbnQgbmVzdGVkX2V2bWNzX2NoZWNrX2Nv
bnRyb2xzKHN0cnVjdCB2bWNzMTIgKnZtY3MxMik7Ci1ib29sIG5lc3RlZF9ldm1jc19sMl90
bGJfZmx1c2hfZW5hYmxlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOworYm9vbCBuZXN0ZWRf
ZXZtY3NfbDJfZGlyZWN0X2h5cGVyY2FsbF9lbmFibGVkKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSk7CiB2b2lkIHZteF9odl9pbmplY3Rfc3ludGhldGljX3ZtZXhpdF9wb3N0X3RsYl9mbHVz
aChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogI2Vsc2UKIHN0YXRpYyBpbmxpbmUgYm9vbCBl
dm1wdHJfaXNfdmFsaWQodTY0IGV2bXB0cikKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92
bXgvbmVzdGVkLmMgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jCmluZGV4IGIyYzg1MWNj
N2Q1Yy4uMjE3NTJkM2E1MTRhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L25lc3Rl
ZC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMKQEAgLTM1NDAsNyArMzU0MCw3
IEBAIHN0YXRpYyBib29sIHZteF9nZXRfbmVzdGVkX3N0YXRlX3BhZ2VzKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSkKIAkvKgogCSAqIE5vdGU6IG5lc3RlZF9nZXRfZXZtY3NfcGFnZSgpIGFs
c28gdXBkYXRlcyAndnBfYXNzaXN0X3BhZ2UnIGNvcHkKIAkgKiBpbiAnc3RydWN0IGt2bV92
Y3B1X2h2JyBpbiBjYXNlIGVWTUNTIGlzIGluIHVzZSwgdGhpcyBpcyBtYW5kYXRvcnkKLQkg
KiB0byBtYWtlIG5lc3RlZF9ldm1jc19sMl90bGJfZmx1c2hfZW5hYmxlZCgpIHdvcmsgY29y
cmVjdGx5IHBvc3QKKwkgKiB0byBtYWtlIG5lc3RlZF9ldm1jc19sMl9kaXJlY3RfaHlwZXJj
YWxsX2VuYWJsZWQoKSB3b3JrIGNvcnJlY3RseSBwb3N0CiAJICogbWlncmF0aW9uLgogCSAq
LwogCWlmICghbmVzdGVkX2dldF9ldm1jc19wYWdlKHZjcHUpKSB7CkBAIC02NTQ5LDcgKzY1
NDksNyBAQCBzdGF0aWMgYm9vbCBuZXN0ZWRfdm14X2wwX3dhbnRzX2V4aXQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LAogCWNhc2UgRVhJVF9SRUFTT05fVk1DQUxMOgogCQkvKiBIeXBlci1W
IEwyIFRMQiBmbHVzaCBoeXBlcmNhbGwgaXMgaGFuZGxlZCBieSBMMCAqLwogCQlyZXR1cm4g
Z3Vlc3RfaHZfY3B1aWRfaGFzX2wyX3RsYl9mbHVzaCh2Y3B1KSAmJgotCQkJbmVzdGVkX2V2
bWNzX2wyX3RsYl9mbHVzaF9lbmFibGVkKHZjcHUpICYmCisJCQluZXN0ZWRfZXZtY3NfbDJf
ZGlyZWN0X2h5cGVyY2FsbF9lbmFibGVkKHZjcHUpICYmCiAJCQlrdm1faHZfaXNfdGxiX2Zs
dXNoX2hjYWxsKHZjcHUpOwogI2VuZGlmCiAJY2FzZSBFWElUX1JFQVNPTl9DUFVJRDoKCmJh
c2UtY29tbWl0OiBjMWY3MzAzMzAyOTI3ZjljYmY0ZWZlZGY3MGYwNTEyY2RlMTY4YzY1Ci0t
IAoyLjUzLjAKCg==

--------------oAkJlQkyexkkEkFyf80JxdBZ--

--------------ms090500000902090604030004
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Kryptografische S/MIME-Signatur

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DIgwggXOMIIDtqADAgECAhA0jOfO6vGomyLc0x3rEwFeMA0GCSqGSIb3DQEBCwUAME4xCzAJ
BgNVBAYTAlBMMSEwHwYDVQQKDBhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xHDAaBgNVBAMM
E0NlcnR1bSBTTUlNRSBSU0EgQ0EwHhcNMjUwODA4MTkxODM4WhcNMjcwODA4MTkxODM3WjA+
MRowGAYDVQQDDBFybm93b3RueUByb3Rlay5hdDEgMB4GCSqGSIb3DQEJARYRcm5vd290bnlA
cm90ZWsuYXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCNNLEVAvIWxa1RRa/+
UsvQEfUOh0GI8YTSKTEHmrahHKGeZt3DlbfMTvAgHBXCMXQ2HwCNxMjPCJHRSI7r8qPFmhzE
8Bh+Qqn1RsAyo+6DN/BFUqAZ7lFcmcW2f6Hw5JCnPiNERbwbpa2PeTAgT5JpgLISkyW/GKF6
2yvaPq5TQHk/ix4fKde7oV8PsQL+qeAMdbhXX5IRQXu9g/hlSXrQ3xmD2EAcZzCHP2JKwh24
cqdMV8A8wqLtPFFUGtnvmO1U0jEv9z0yhUKYFX/rFZlv/87OIsp1SAhPlVRK068PiPCbhcfE
/SNB4T3VuxDZoREVZwZNbboXuWyls1KjmKdJAgMBAAGjggG2MIIBsjAMBgNVHRMBAf8EAjAA
MEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jc21pbWVyc2FjYS5jcmwuY2VydHVtLnBsL2Nz
bWltZXJzYWNhLmNybDCBgwYIKwYBBQUHAQEEdzB1MC4GCCsGAQUFBzABhiJodHRwOi8vY3Nt
aW1lcnNhY2Eub2NzcC1jZXJ0dW0uY29tMEMGCCsGAQUFBzAChjdodHRwOi8vY3NtaW1lcnNh
Y2EucmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3NtaW1lcnNhY2EuY2VyMB8GA1UdIwQYMBaAFGb7
ww++9L/gnMmrTd5HGb3AyqZoMB0GA1UdDgQWBBST9SgVFYE2z6eBp5WoD47djhjtzzBMBgNV
HSAERTBDMAkGB2eBDAEFAQIwNgYLKoRoAYb2dwJkAgEwJzAlBggrBgEFBQcCARYZaHR0cHM6
Ly93d3cuY2VydHVtLnBsL0NQUzAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwDgYD
VR0PAQH/BAQDAgTwMBwGA1UdEQQVMBOBEXJub3dvdG55QHJvdGVrLmF0MA0GCSqGSIb3DQEB
CwUAA4ICAQAiAguFMs6YPW2EdsKwO4fTBTKvCiKq3Q/g8jXWd3/flBRj5MAlTdlPq1YSE2eA
fisqb5JjNcMY9mhqUlLleHGun4fsN4qOwnEEsGU47D5g4jpjDHN39SUDW3zqGf1cwF58iYLf
/bUiS/UTtcL0gSASxS0jlSv224U/VW9qBlc3gP1RAZT06oU13p93Ixrc7xwu7hv1IEREHDgb
WOwY4UHXNegozMi4FeGikGHR1e0totyBPimFQiOUvrHVQYrJ/oQMl0kYDrvtMT8U/DdBjB2b
Opsp/ULJLlVlpm/AKlHxpQkQR/hRJaWQ20hhyKGqFliQU4m16/mmDNlMqnubtjgrlHJopvSm
AO58rKZ6vFY4LomvhfYgHvEK7upYrydFlRjMVbsZ730wbD3/YvuoU8aV17EeQACQiRopmk/V
US5ZUaihgJLVSa4/x02OHi5+PdKoWBs0QQ9Vf5tZQPnyhQVh1WMlzAg4o5LPGCg3HV+BKfJy
HW7G5eudI6KZQEwfFAQvibNxpNB+LsMqlBZkvPNvykPEjr8krevb0n5NPEiUj4Hj2Vo1POOn
Ecqi2CLfBM0Sg2cJw4VeonwUNjBf8RIby7Ef+SPN+ZDXdTF6sLdxbeOg3OeXtvuPFmnCzeKf
j93fGC8H3kNjG/68kMD8KhI9J9qgd6mKcrfTUUEB8PUVUjCCBrIwggSaoAMCAQICEAzhMieo
LOaj0PNXw2y2HoYwDQYJKoZIhvcNAQENBQAwejELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFz
c2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEnMCUGA1UECxMeQ2VydHVtIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MR8wHQYDVQQDExZDZXJ0dW0gVHJ1c3RlZCBSb290IENBMB4XDTIzMDgwMTA4
MDk0OVoXDTM4MDcyMzA4MDk0OVowTjELMAkGA1UEBhMCUEwxITAfBgNVBAoMGEFzc2VjbyBE
YXRhIFN5c3RlbXMgUy5BLjEcMBoGA1UEAwwTQ2VydHVtIFNNSU1FIFJTQSBDQTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANO53F9Me+oQiFXAMHhkMMmr58MGrVr6cIEJMZ2e
PfbpEaQJLYTVDregdPCUP22Qm3prxQPAghnp4bz84iQz8D4raXMysFw/10QF0ZmoJfBuqrg7
hn8+Xyibs7sblvCdppykWksZNei2Do9P9H1RZcxb5LUjkqKisFdE54VfQ34JuvJR8JCPS8Hk
XzlherIeRpl2A7xh0v6P6l9RE4kYt2cZ9/pvf47nxsFnp/ghRU4BGHJpotDLWh+fCRXQAzZa
X8AiMDwqvC1E6HTPn8XeTxJTI3K8hBobS8/Jy0dFYuxcZuTAejfA6ldLgqQBBHXNH5QsMYIw
WFFJf+P+yQnFiYC2ptT6/nrBh4sQz0uZ9MKw5KtjzI1GKnQ9BLgWtnKLzzxYLj2IEvMyS074
kSyYMiIBgOT2SMP1YCG5uHyI3/lF25xXP2W6R8JrT6NgfuxGGlzXYfdsza5+9NtEgTlbUJFo
AuIbOURbOEDdRYgFtr5jgGuG23GuvAob185EC5ucV7TIMKddwcLg33RgjAnjiw/QGAL0uMZH
49k1PO9ICP6oKZnrEk49SWyyXofJwQ9Toqxb0qeVmYROxypwL5XejMGTzEzRVn8Adnfilclx
6Z9Ybh7ivF4fQVJ3BQTOPeRMDzg6pHFtv8LbVeyJLVfJPcpQgaUOIgRAWCcP1OT88akTAgMB
AAGjggFeMIIBWjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRm+8MPvvS/4JzJq03eRxm9
wMqmaDAfBgNVHSMEGDAWgBSM+xx1vALTn04uSNn5YFSqxLNP+jAOBgNVHQ8BAf8EBAMCAQYw
HQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMC8GA1UdHwQoMCYwJKAioCCGHmh0dHA6
Ly9jcmwuY2VydHVtLnBsL2N0cmNhLmNybDBrBggrBgEFBQcBAQRfMF0wKAYIKwYBBQUHMAGG
HGh0dHA6Ly9zdWJjYS5vY3NwLWNlcnR1bS5jb20wMQYIKwYBBQUHMAKGJWh0dHA6Ly9yZXBv
c2l0b3J5LmNlcnR1bS5wbC9jdHJjYS5jZXIwOgYDVR0gBDMwMTAvBgRVHSAAMCcwJQYIKwYB
BQUHAgEWGWh0dHBzOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJKoZIhvcNAQENBQADggIBAAJ1
aIVOsRd6NsI2G+VAaOcavgbAIFFFyzX65C6ZJyKS0q5yyPWYJve2YHT1sPJrRt5JQNV53+H5
9s8oWU43aaLBFhnB0ZdIU2vKfMYLWhhAbdI9LqrBdLaJl7iRDh3SlNGe0Y94dF7Xejmd3e0n
D/5dqdShNHLv83Y3FDwGvXq/4xro3ZeqouP7NcYyfyHlzQumaqeRozGTaGIvFcQ4sWgZdc6K
XfAcKSC2VmB9uDJ4r8AaOoSP1c18MJ7ZXh9MuxiqVv4BpUAylcW17N4YuuwgB5/4xiNc2gYp
gZ4czwCI0d4jFq+Tjk70S29p3+Uq89wfSGAyv3BNF4JGeaOmh0eDFwobQssjqstHhFsR9F/e
tXzHJHoqR+MjLtbyk38LH+LwP+sAzjphxLbzV27PjdfQ5rDpSOKoXCJp7wN4q9Mg0sFH7J8l
1D+Uuyw0AbdA3FdEejM0lSn9R6pSd/VZALg1ptBcqnniFZMJIF5z6fnnT5ESD8/60OL5SygW
qIT0ynP8j8qkDcUbKGkPFhsuLD97Sdguq3UepfwXgviwt9bfjqsQe0FZU0+axCYuMjqZ+Gbx
zgVfeN+dCjA8Mu+o0Ymw795zf3t7Jvyc37wxIzUpc9WwyHgu9Fm+NUvQNUR84YF/b0dYRdi4
nmWWFj383fVrLgay/rVWAUTu/2FCMzhkMYIEPTCCBDkCAQEwYjBOMQswCQYDVQQGEwJQTDEh
MB8GA1UECgwYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMRwwGgYDVQQDDBNDZXJ0dW0gU01J
TUUgUlNBIENBAhA0jOfO6vGomyLc0x3rEwFeMA0GCWCGSAFlAwQCAQUAoIICrDAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MTcxOTUwNTZaMC8GCSqG
SIb3DQEJBDEiBCBxP2kxyjwKNFRKlJuY00FYDZR6rh9rkF3AA/aPabA23TBxBgkrBgEEAYI3
EAQxZDBiME4xCzAJBgNVBAYTAlBMMSEwHwYDVQQKDBhBc3NlY28gRGF0YSBTeXN0ZW1zIFMu
QS4xHDAaBgNVBAMME0NlcnR1bSBTTUlNRSBSU0EgQ0ECEDSM587q8aibItzTHesTAV4wcwYL
KoZIhvcNAQkQAgsxZKBiME4xCzAJBgNVBAYTAlBMMSEwHwYDVQQKDBhBc3NlY28gRGF0YSBT
eXN0ZW1zIFMuQS4xHDAaBgNVBAMME0NlcnR1bSBTTUlNRSBSU0EgQ0ECEDSM587q8aibItzT
HesTAV4wggFXBgkqhkiG9w0BCQ8xggFIMIIBRDALBglghkgBZQMEASowCwYJYIZIAWUDBAEC
MAoGCCqGSIb3DQMHMA0GCCqGSIb3DQMCAgEFMA0GCCqGSIb3DQMCAgEFMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEFMAcGBSsOAwIaMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgIwCwYJYIZI
AWUDBAIDMAsGCWCGSAFlAwQCBDALBglghkgBZQMEAgcwCwYJYIZIAWUDBAIIMAsGCWCGSAFl
AwQCCTALBglghkgBZQMEAgowCwYJKoZIhvcNAQEBMAsGCSuBBRCGSD8AAjAIBgYrgQQBCwAw
CAYGK4EEAQsBMAgGBiuBBAELAjAIBgYrgQQBCwMwCwYJK4EFEIZIPwADMAgGBiuBBAEOADAI
BgYrgQQBDgEwCAYGK4EEAQ4CMAgGBiuBBAEOAzANBgkqhkiG9w0BAQEFAASCAQCIhzXdBM63
nIqg2wTA0CQyvwgMQo9btqxtfXA+DN5yZ4PDiGdOvo1d/Aq9U9BH40jMIGQVYvSLjH2qdLdF
FAnNJhgtrH6wEvaJ1cjPuwyqEfipjrwwZRyAgAywMTs6cBy1ioA2bXMUIMqSNIPgnzgMBAJv
ceRv6mTAzYxv0S1e8D/A2x83FkkrDtSb4IbM4/Q5XDpyx/Z/mlLVmUj7vV3vKZqIgfpqCCww
DVThGYrwNq63X6D0xLEneyhz2ex2CwpTCNG9s5/LgaTVovsJASoyK8dMwuRfGONIB71MgHZc
2hMLWNaiQ5rNaPn+Oz3cnDMiYt289epHEPi8BOQk2N/RAAAAAAAA
--------------ms090500000902090604030004--
