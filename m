Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792946273;
	b=rZ/3Yco0Brq8NiYZYAUwrXP9pyYnl4DOMZ9SUqhQ9imf4Fd3FzB0ZQT/c6ep69xw6t3M
	 b2iCaj7SJubJXkd0id732STzTE3yDjKaMfCJwZVTdSjuBuXSRhFBO0iGmrbsYkSfOa3Ky
	 YJ1TGhciHOGkMT6aHevPgpXA5PrsERYPPtO4YmYjtoivVkEK/oe8pFdf0t6LJNDAlGXEV
	 fv4XnpURjyvpl8mwtF+uu6EY2Ew35N5DmCI4HIaaNRELxi2/LCtm1JJwbXCqHt8JLzNk1
	 mg3P05x7cmPSMxZqYFc1fZatkZOf58hA7UaBe7X4qp2DrGXkomqnQTEgzAhT+mHzQTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
	b=Wsu2zfpzyDT5cZQ445LhhgTBYFz6SUti9NjLjEOT942Ixd5+SJEmossUDn8rRHybIsp5
	 66uD2CW9CBH1uJ6I4bsXuDL/iEiW1tlh7hgcl18NGogxYAzlMXSi3RC9JEFAGyIv1qEsh
	 XAPKG95waeC79DZ1udD9hoza0RkPnHrq+RQSdjFYL5b8lwDkca9k6WXMrCc0Gc5gYQ0K5
	 6Whiop5AxVqBKLe9BM/tSGRZU5X782Hd89pqIxMMjOwWF8Rn3hSlMOI3KkQIou/KRxFPW
	 J2Fko6mkwx6jPoj06wn/N0viAQhYL6HAtvwHkQTguptgyrWCLjtAHGaxVh05/p4VuXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqtfCj0N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A3606A31B
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0A3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqtfCj0N
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso332165766b.2
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 09:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792946272; cv=none;
        d=google.com; s=arc-20260327;
        b=TaQR4m1YqHxdYFrWiwXG8GJhOYIZEGej/SEx14DGgWuqyzqtP2aj3545IRC8k15ncP
         /lFImOj+JDpTxSmsHAQBWwmTZJru4BjRzQo/WQ5wXpoRhSJDHnij9WuJeI9W2Y0SSH9O
         v1jHHvdj9qW5EoRkBPWc6Emo7I0jyNCOlusAygHtlNkGIKPPH3YJqqVlm1FzxnGgTH+d
         rXJoQSSqbsTDWur6dmsRLldzFxQXTP+KRxbxLl7Be2l+EwnYy6DvBsYMSjNGGkb93B3g
         YOjcZhjQ7WwqXsmKiHxuptN21ctB7uUW2jCpXP+d+Sww4/V9F+4VMcvg2LygdV6vITzK
         VZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        fh=0RWBDfeli0JM+vo0mw2N5d5rZqfUgYQw1KQjLGHaVsU=;
        b=dVZSbz2C8sDtkjMO6dERII5kws1NDIw1dIfXTC5ZVWLnbL5rpVQIDJ09FCc8JRNB/y
         ymGhDkwlQp34RVqfvULFL1/1jvzt1SVTm2A9n2vUWcOVTxE7xexHdEgqjhLoDatKb46l
         zFi1sHrlzTjWRGdzCA3+jFT0WMi6RGhyo5AMa6AqqpeaXl7el9ijv4lOjtUVr38sPqg+
         qTxJeA2job8T7c4cG9/mqSv3bQInbdBpS1s4lEORgGIhSGmfH4lfD+CKEr4H4v3w+mi7
         zdtSUQJfZZTuJhzS7GuA+8iqQWlYDo7ufgRKM+SjgjIUKeaYagxM3MoVlExi7NnuodZ6
         lJRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946272; x=1793551072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        b=SqtfCj0NSw1HMP6RUrCMTPSEJqaZadedt00MpaTnabM6VctJ7hcHrzcU89KV2lnp0i
         UU+flw+uNuevzS6kRAn9I3xzFxHKgwAB0p5LrZwzENbxC5oSkjXQ9KcVbNwPp7DpP6Xi
         +HOkYWJZRoEyreYGFe4Z5Ka3B2WFhfVk0fTqWFQk06NFuF8Xq9FQjTMs8OQL5sYkFeYa
         bV0gPIwW+QcxyvgKD6ZQAQZpxsSQZKb0lNc7k/vcjvmFKy92eabPZsRBTdors+ezsr3B
         poB6nY61HzVKYaAdqLX4SgICua+HA7X3Zy0lqnmXFN4w8d5UOgdfU4CcqThaU+BUxV71
         feHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946272; x=1793551072;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/NYcBft1kVvO/YobYFxSUg+hqb3bNu6yzSqebc0Ktoc=;
        b=FMQoad32+Q61K/Ku6CSq96rMvDdaE4zZiGZFKIcbeZI7RO3tX5MCyeesldSexWSRaF
         MqyKlWd90Poyq8ylGRmd1atiEylKHRQR2FW7fOWBqvE7ROY2jWOQZTfIQ/cs444Tyrav
         wHvVqWXJuZY8ZfTYuU3q0T0oiThxLyyD+CUyRqOCEyvVWIXlP0S1qEI1iZV1OwEHBzLX
         bygq0BfCU8XDk9LuJbXuQiqYNSVpdcNQhVaLLkCzn4yHO/N7RwXWqIIhPkfWtxB1ON3c
         6QSI7SCZ0vnZwHUx39p4ctE/NnLB3cmyE0aaDod5WElolyIjqiGztbJwpIMlnObaLpdk
         c4Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxfjFoAKyedQW0XcSNV570QSlBIWamMGPBknsjhOVcQlv3n35ii+mOPglT/D8WwJjz9hwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjMqXkTyOtlB2UY+Bv5lrc/JEc4l9IikqJRoVJDYOq3PSFU3hp
	EABLevhdHV7DtRUhGWeonKQkbmyF+CXFuG+E4hBGG0KmpvgvHXTnXakFVZZT/bPiPn8MKRW/MpR
	uPG2Q9MTczoEuW6eIMTJmy9HmpIbc4zE4HQ==
X-Gm-Gg: AYBFou07s3QYH+HSYU9reRcMR2iZr+Im/IMY3YOKip/isAYzesXeu+Iy606jl+4JFFx
	SFIn+R4RaPsONZOhuHUIOJS4wdQXKXUVYwYTdQBbpz1e1TLy0dZw5ytGPl+2xUC2aznbJymHDPI
	jnYPhng+RbKY5r/HW8Q1ri4mzxW+uYkiKWcHsSy1bXdMhVLRlvvudKxqi7jOLGqtIBsUNfs54OD
	wtfJ+DGOGXEzg4DZVcQDjkQgOifPgSyUk3VxdL1wgHXgj9qFK4c3S3DTOvzuCyloKvbUtlRflh0
	Ab7lvlSeCq6GMaSz8ceQJUJ88nlzbzo0KvC+LLkSE3FXO/2TCPZjcxFeqrwpVU5iLYW1QXuA1Y0
	Z3mRnLoD7PYaZetNAibCbJh2rulk72LeOln72u6yZxKe4Nyh/OEmdsGmckvHQWSdHn8PvsgZ7oa
	8f6kRtbz6MjwtHqJ4WOMkyTv7YB7tVK77fmhLBOO37oJBX+AFth4g=
X-Received: by 2002:a17:907:3e9d:b0:c29:f5d8:9c78 with SMTP id
 a640c23a62f3a-c46bde88fafmr593007066b.39.1792946271297; Sun, 25 Oct 2026
 09:37:51 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Patryk Janik <patrykjanik1710@gmail.com>
Date: Sun, 25 Oct 2026 17:37:39 +0100
X-Gm-Features: AclHuK8JW6Yyw3DwchvYU0e0Y3kSChVcpTtp6xH8i4tDZxFVFWSrnttTamaQBd4
Message-ID: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>
Subject: [PATCH RFC] PCI: Don't restore state of a device whose config space
 is inaccessible
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: alex@shazbot.org, kvm@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009a5aef065eacd5e3"

--0000000000009a5aef065eacd5e3
Content-Type: text/plain; charset="UTF-8"

After a failed reset, vfio_pci_core_disable() unconditionally calls
pci_restore_state(). When the device did not come back (FLR timed out,
config reads return ~0), restoring state walks the extended capability
list and rewrites the whole config space. Every one of those accesses
stalls for a completion timeout, so the host spends minutes in soft
lockups instead of failing fast.

Seen with an NVIDIA RTX PRO 6000 Blackwell Max-Q (10de:2bb4) on vfio-pci
after the guest was terminated (Ubuntu 6.8.0-147, code path unchanged in
v7.3):

  vfio-pci 0000:81:00.0: not ready 65535ms after FLR; giving up
  watchdog: BUG: soft lockup - CPU#9 stuck for 28s! [worker:361063]
  RIP: 0010:pci_mmcfg_read+0xba/0x110
  Call Trace:
   pci_read_config_dword+0x27/0x50
   pci_find_next_ext_capability+0x83/0xe0
   pci_find_ext_capability+0x12/0x20
   pci_restore_ltr_state+0x29/0x60
   pci_restore_state+0x16/0x270
   vfio_pci_core_disable+0x339/0x440 [vfio_pci_core]
   vfio_pci_core_close_device+0x68/0xe0 [vfio_pci_core]

191 soft lockups followed over ~2.7 hours, until the host was power
cycled. The device itself is a separate (firmware) problem and stays
dead either way; this patch only stops the host from hammering it.

pci_save_state() and pcie_flr() already bail out through
pci_dev_config_accessible(); do the same in pci_restore_state().

Signed-off-by: Patryk Janik <patrykjanik1710@gmail.com>
---
RFC: written against v7.3 (master 21a7f44fd076); not tested on hardware
yet. Happy to test a revised version on the affected machine.

Full report, timeline, nvidia-bug-report.log and the complete kernel log
of the failing boot are attached to the NVIDIA forum topic:
https://forums.developer.nvidia.com/t/386790

Related:
- "PCI: Avoid FLR for NVIDIA 5090 GPU" (linux-pci, 2026-04-16), where the
  underlying FLR failure was described as a known device firmware defect.
- nova-core "run unload sequence" series (merged v7.2), which mentions a
  Blackwell VBIOS bug that sometimes breaks the GPU upon PCI reset.

 drivers/pci/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1883,6 +1883,16 @@
  */
 void pci_restore_state(struct pci_dev *dev)
 {
+ /*
+ * A device that did not come back from reset (e.g. an FLR that
+ * timed out) returns ~0 for every config read. Restoring state
+ * would walk the extended capability list and write the whole
+ * config space, each access stalling for a completion timeout,
+ * which shows up as minutes of soft lockups. Bail out instead.
+ */
+ if (!pci_dev_config_accessible(dev, "restore state"))
+ return;
+
  pci_restore_pcie_state(dev);
  pci_restore_pasid_state(dev);
  pci_restore_pri_state(dev);
--
2.47.0

--0000000000009a5aef065eacd5e3
Content-Type: application/octet-stream; 
	name="0001-PCI-dont-restore-inaccessible-device.patch"
Content-Disposition: attachment; 
	filename="0001-PCI-dont-restore-inaccessible-device.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvo1uysf0>
X-Attachment-Id: f_mvo1uysf0

RnJvbTogPHlvdXIgbmFtZT4gPDx5b3VyIGVtYWlsPj4KU3ViamVjdDogW1BBVENIIFJGQ10gUENJ
OiBEb24ndCByZXN0b3JlIHN0YXRlIG9mIGEgZGV2aWNlIHdob3NlIGNvbmZpZyBzcGFjZSBpcyBp
bmFjY2Vzc2libGUKCkFmdGVyIGEgZmFpbGVkIHJlc2V0LCB2ZmlvX3BjaV9jb3JlX2Rpc2FibGUo
KSB1bmNvbmRpdGlvbmFsbHkgY2FsbHMKcGNpX3Jlc3RvcmVfc3RhdGUoKS4gIFdoZW4gdGhlIGRl
dmljZSBkaWQgbm90IGNvbWUgYmFjayAoRkxSIHRpbWVkIG91dCwKY29uZmlnIHJlYWRzIHJldHVy
biB+MCksIHJlc3RvcmluZyBzdGF0ZSB3YWxrcyB0aGUgZXh0ZW5kZWQgY2FwYWJpbGl0eQpsaXN0
IGFuZCByZXdyaXRlcyB0aGUgd2hvbGUgY29uZmlnIHNwYWNlLiAgRXZlcnkgb25lIG9mIHRob3Nl
IGFjY2Vzc2VzCnN0YWxscyBmb3IgYSBjb21wbGV0aW9uIHRpbWVvdXQsIHNvIHRoZSBob3N0IHNw
ZW5kcyBtaW51dGVzIGluIHNvZnQKbG9ja3VwcyBpbnN0ZWFkIG9mIGZhaWxpbmcgZmFzdC4KClNl
ZW4gd2l0aCBhbiBOVklESUEgUlRYIFBSTyA2MDAwIEJsYWNrd2VsbCBNYXgtUSAoMTBkZToyYmI0
KSBvbiB2ZmlvLXBjaQphZnRlciB0aGUgZ3Vlc3Qgd2FzIGtpbGxlZDoKCiAgdmZpby1wY2kgMDAw
MDo4MTowMC4wOiBub3QgcmVhZHkgNjU1MzVtcyBhZnRlciBGTFI7IGdpdmluZyB1cAogIHdhdGNo
ZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzkgc3R1Y2sgZm9yIDI4cyEgW3dvcmtlcjozNjEw
NjNdCiAgUklQOiAwMDEwOnBjaV9tbWNmZ19yZWFkKzB4YmEvMHgxMTAKICAgcGNpX2ZpbmRfZXh0
X2NhcGFiaWxpdHkrMHgxMi8weDIwCiAgIHBjaV9yZXN0b3JlX2x0cl9zdGF0ZSsweDI5LzB4NjAK
ICAgcGNpX3Jlc3RvcmVfc3RhdGUrMHgxNi8weDI3MAogICB2ZmlvX3BjaV9jb3JlX2Rpc2FibGUr
MHgzMzkvMHg0NDAgW3ZmaW9fcGNpX2NvcmVdCgoxOTEgc29mdCBsb2NrdXBzIGZvbGxvd2VkIG92
ZXIgfjIuNyBob3VycywgdW50aWwgdGhlIGhvc3Qgd2FzIHBvd2VyCmN5Y2xlZC4gIFRoZSBkZXZp
Y2UgaXRzZWxmIGlzIGEgc2VwYXJhdGUgKGZpcm13YXJlKSBwcm9ibGVtIGFuZCBzdGF5cwpkZWFk
IGVpdGhlciB3YXk7IHRoaXMgcGF0Y2ggb25seSBzdG9wcyB0aGUgaG9zdCBmcm9tIGhhbW1lcmlu
ZyBpdC4KCnBjaV9zYXZlX3N0YXRlKCkgYW5kIHBjaWVfZmxyKCkgYWxyZWFkeSBiYWlsIG91dCB0
aHJvdWdoCnBjaV9kZXZfY29uZmlnX2FjY2Vzc2libGUoKTsgZG8gdGhlIHNhbWUgaW4gcGNpX3Jl
c3RvcmVfc3RhdGUoKS4KClNpZ25lZC1vZmYtYnk6IDx5b3VyIG5hbWU+IDw8eW91ciBlbWFpbD4+
Ci0tLQpSRkM6IHdyaXR0ZW4gYWdhaW5zdCB2Ny4zIG1hc3RlciAoMjFhN2Y0NGZkMDc2KTsgbm90
IHRlc3RlZCBvbiBoYXJkd2FyZSB5ZXQuCgotLS0gYS9kcml2ZXJzL3BjaS9wY2kuYworKysgYi9k
cml2ZXJzL3BjaS9wY2kuYwpAQCAtMTg4Myw2ICsxODgzLDE2IEBACiAgKi8KIHZvaWQgcGNpX3Jl
c3RvcmVfc3RhdGUoc3RydWN0IHBjaV9kZXYgKmRldikKIHsKKwkvKgorCSAqIEEgZGV2aWNlIHRo
YXQgZGlkIG5vdCBjb21lIGJhY2sgZnJvbSByZXNldCAoZS5nLiBhbiBGTFIgdGhhdAorCSAqIHRp
bWVkIG91dCkgcmV0dXJucyB+MCBmb3IgZXZlcnkgY29uZmlnIHJlYWQuICBSZXN0b3Jpbmcgc3Rh
dGUKKwkgKiB3b3VsZCB3YWxrIHRoZSBleHRlbmRlZCBjYXBhYmlsaXR5IGxpc3QgYW5kIHdyaXRl
IHRoZSB3aG9sZQorCSAqIGNvbmZpZyBzcGFjZSwgZWFjaCBhY2Nlc3Mgc3RhbGxpbmcgZm9yIGEg
Y29tcGxldGlvbiB0aW1lb3V0LAorCSAqIHdoaWNoIHNob3dzIHVwIGFzIG1pbnV0ZXMgb2Ygc29m
dCBsb2NrdXBzLiAgQmFpbCBvdXQgaW5zdGVhZC4KKwkgKi8KKwlpZiAoIXBjaV9kZXZfY29uZmln
X2FjY2Vzc2libGUoZGV2LCAicmVzdG9yZSBzdGF0ZSIpKQorCQlyZXR1cm47CisKIAlwY2lfcmVz
dG9yZV9wY2llX3N0YXRlKGRldik7CiAJcGNpX3Jlc3RvcmVfcGFzaWRfc3RhdGUoZGV2KTsKIAlw
Y2lfcmVzdG9yZV9wcmlfc3RhdGUoZGV2KTsK
--0000000000009a5aef065eacd5e3--
