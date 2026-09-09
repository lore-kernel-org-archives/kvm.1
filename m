Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6025947EA
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988444; cv=pass; b=lAr60Q9IqBPptTuW9byJZI7OuWrqI3kgo9rRRMIhSWlaOrtte58XrAVEYusSE85RkCBeXER4EKReRE5WWOWCDVLa6x1IYAAZ6aeRW924v0HWi0JYF82WyHDQpU2Och4GQGHM2QpF1Ut8uqRaCK9Obhsm5wfH3sy4yHAAb/cYSCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988444; c=relaxed/simple;
	bh=/wJ64Pe4/ozV6BllMTCl47Au3a82RPV4UUcvBzLBruQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y6iDHzYlOo5pe2XHGuH3zEPLMJMZ7EfZ+MIIMUk+Y3g41ShUL9d6doWmzFU+w6eRMd/qIb/wZrKvEHboV7lawFKuBY/uszFFMm8bbFGXPKazadDhq7w/s4K3I6gXXpabBysIB6ZizKn3bbVzioAUYmm375DouNKOURrDR+HCu6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBgGhCn6; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBgGhCn6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c293ae2bab5so134864966b.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 14:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788988436; cv=none;
        d=google.com; s=arc-20260327;
        b=GpQvp5v4RgL7/h0oxBxkzNloMf0BNZZgfKsxZybCFJK+z1sjQDP/RJBcX4vr1gouNb
         /3mZYysOb0HRI8gvNttDFGJj+CUV13yaTvDDtzVuuqQj5NCYP3Np1X0m94cLk1SA3wOx
         RpMTHsLWi3P3BhuGsv57dTkaxbd4SGy1QZh5GIiaHIXC+IkzYIPCjquQF41cjLD5VNm2
         /RuL2uD4lY/5e80zuZBdVgkD6YW43csknb/4Y06R1w3TgGN7B+kUIoGZN4V1Q4H2wNZC
         gSLRZl6ir178QjjoKpp75H0lkaM7rcfikpXbyb9p8PzqzTrqT1D0SjHOS2/LWGR6conL
         4IcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/wJ64Pe4/ozV6BllMTCl47Au3a82RPV4UUcvBzLBruQ=;
        fh=xKgzBsgnITz865bALk5Cp2otXcsfH5ggA+HYAq2E2yA=;
        b=TinlCbHk4aylYHvzZY32JqOAH6/KpgESHR4yVdKvk/RhceHg1kLc1JSNTZBvWoteIn
         CPlhdngQMKPcG1zh8eJ3EdYQakLvq4fW7Kf99lBW1dSIgOyiVZZ7fuSQAs6EQhoriUDC
         Jim7pp/xiZeurY660ODmirlHxfyPZuepNAO+tBO949tFwIPJUXC5IbnVewRztOuXVF2Z
         8LQ3F3H4LGb4KhvB+5TLX+4YMQHVG1ocne4hy2ThSU+PxGmdJ/RuhrCZLKzhrbibmnPN
         DPpRgU12yOz21cR/zeYgNsJ8Dnw/yvQSNRQCnA5Wnka6gwppgvOVcNgQhkIu/fNvOlFw
         C/Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988436; x=1789593236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wJ64Pe4/ozV6BllMTCl47Au3a82RPV4UUcvBzLBruQ=;
        b=NBgGhCn6ALG2I7yL8cDRsyvnlovoCNUdAzy0swYA2EHeV1o++cF1ByOAAwk3cGoxvq
         okRoq0sXMgO1dkbxmBHDeAfUyABD6qmyjea7itadpuKRrV6suVzu79T8NZzAvp5FkTWi
         jbU+lcT06Pvhnb14vqgS3YRHm63zfLO2Xl0wH10uDJt27vlMOtS1UMqxtPhCM40VmFck
         mX7bWGh3VhOZfU73qe2sqH7A3wAYnxmQqXskr+sJTDOgr/XGPwhPIW6qG6A02DTj0SBk
         1HPGJ8H0KDvx6LeCH1f2irf8i7QiznIPkOSrBbtwWL/G1i2c3n5dGYafrcyksxKm3SzW
         Ju4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988436; x=1789593236;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/wJ64Pe4/ozV6BllMTCl47Au3a82RPV4UUcvBzLBruQ=;
        b=RTq78na1G6tNqPde6uWhw/pUpvjNvrX2G6iDMSWI15uedRcwNXzFN3xFgk5fD/r1q1
         YNS1qDWcEcRV9vqesUTk0cC5SyzioVk5SHORY2/dmNyxawrw+mjB8B4bpWrBvMeRnw7o
         s7Q+vfQdjbCINbIGWuK3Sixveu1Yzd1jT9WQYZU2D+vJQNKpy5mfnb0+s7lDSEIAMDJo
         10N7wLmMpY4EUe+HHkIjm521VC0WutKR/ghGYUkS/8nNC62vOXcw1eV2aeRcjLQXXoib
         l+OWSnVDpzYLca6VHMSFlnmG+dbeyOTTNcJ92LSwTeVOY7Lj7v4b3xpRKLLOdab1A5Jm
         SKfA==
X-Gm-Message-State: AFuF++mRp+9wTpitpv7NmJvy4/EGAsqYMDAmJP2IyZzzHO58PamRKvZr
	XFfJHPphf275pLiuoKhRCLH1ZZAkhpw0b5DXpvrQHIjJA9T3CrWVuNyKY9NrPmzub/3elJTvlQW
	X76zUa5CecURSBl4lnx4cJzoYJMRZA4MWO2fRABA=
X-Gm-Gg: AYBFou0W31xLp9prZq2RDDRNZgKO9ljYnnpU7bN9mDfHtz2u8499NyIePfBFJS6TduV
	qrSHHFuUIHgNwNdr5tH7jWstcvN63DEeiCAELsEFFVxLLtE9E6CocShk1IXulK5o+Sdjg4vWPx3
	yJDte1kWKzmvqABTSw/ohLYRbk1CEuX4D9uF7w4X5XOz6Mj1LBa7a2SdfVfj/8+Uz0fAbnyPEdc
	Vv71KMVo90sEmJvFB7AuS6F8nSFYD0lMnRL/hagTt5a35I3ZBInbAMPa09/HBKBcIOLGjT9tE+t
	w9JvaGS8fG4VtQSSDxUys4F9t0p/CTaO9Q+BoBkthEaEQPnAw0QAOIk+EqgUMWvP5zMEohrdpRd
	R1phP2kDI51M9fsHF0AXikbdH7YVrQSWf2Z2UNntm215FrGLL2Two8m2bZfPe2SijW6tsolEfA+
	YPs4fnmJszxWTI51C+EeQPo1Vaqg==
X-Received: by 2002:a17:907:72d5:b0:c26:1691:b361 with SMTP id
 a640c23a62f3a-c261691b94dmr1360580666b.26.1788988435532; Wed, 09 Sep 2026
 14:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yoch melka <yoch.melka@gmail.com>
Date: Thu, 10 Sep 2026 00:13:44 +0300
X-Gm-Features: AcwNN1WHXOYNUUyuXgjvzhzuCMHaQku120mtQh0ubwqkIrgJBzgyrmbScCDyR-8
Message-ID: <CADQ=hX1Cra96=kVaw6FTUm9yJvherKWCSjWbFtQOaFQu2YNr8w@mail.gmail.com>
Subject: [BUG] AMX tile data lost after nanosleep in a Linux guest
To: x86@kernel.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000354652065b1354d6"

--000000000000354652065b1354d6
Content-Type: multipart/alternative; boundary="000000000000354651065b1354d4"

--000000000000354651065b1354d4
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm seeing AMX tile data silently turn to zero after a 1 ms sleep on a
Linux guest.

The reproducer requests AMX permission, loads a known nonzero pattern into
all eight tiles, calls `nanosleep` through a direct syscall, then stores
and checks the contents. There are no function calls while the tiles are
live; I checked the disassembly with both GCC and Clang.

Build and run on an AMX-capable CPU (replace CPU 0 with an allowed CPU if
necessary):

```
gcc -O2 -g -Wall -Wextra -Werror -mamx-tile -fno-plt amx_min.c -o amx_min

timeout --kill-after=2s 20s taskset -c 0 ./amx_min
timeout --kill-after=2s 20s taskset -c 0 ./amx_min getpid
```

Expected: 0/300 mismatches in both modes.

Observed with GCC 13.3.0: 5/300, 5/300 and 4/300 mismatches in three
`nanosleep` runs. Clang 18.1.3 also reproduces it (3/300). The `getpid`
control was clean in all three control runs (two GCC, one Clang).

The first mismatch reports:
First mismatch: 8192/8192 bytes are zero; TILECFG unchanged

`nanosleep` returns successfully. The failure is intermittent, so a clean
run may need repeating.

Environment:
Ubuntu 24.04, custom Linux 6.12.94+
#1 SMP PREEMPT_DYNAMIC Mon Sep 7 16:15:06 UTC 2026
Intel Xeon, family 6, model 207, stepping 2; 4 vCPUs
KVM reported by the guest; host kernel and VMM unknown

A separate test also loses tile data in a busy loop under CPU contention,
without any syscall while the tiles are live. This suggests an AMX
state-preservation issue around scheduling, but I cannot tell whether the
fault is in the custom guest kernel or the host environment.

Does this resemble a known issue?
Any suggestions for narrowing it down from inside the guest would be
appreciated.

Thanks,
Joshua Melka

--000000000000354651065b1354d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I&#39;m seeing AMX tile data silently turn to z=
ero after a 1 ms sleep on a Linux guest.<br><br>The reproducer requests AMX=
 permission, loads a known nonzero pattern into all eight tiles, calls `nan=
osleep` through a direct syscall, then stores and checks the contents. Ther=
e are no function calls while the tiles are live; I checked the disassembly=
 with both GCC and Clang.<br><br>Build and run on an AMX-capable CPU (repla=
ce CPU 0 with an allowed CPU if necessary):<br><br>```<br>gcc -O2 -g -Wall =
-Wextra -Werror -mamx-tile -fno-plt amx_min.c -o amx_min<br><br>timeout --k=
ill-after=3D2s 20s taskset -c 0 ./amx_min<br>timeout --kill-after=3D2s 20s =
taskset -c 0 ./amx_min getpid<br>```<br><br>Expected: 0/300 mismatches in b=
oth modes.<br><br>Observed with GCC 13.3.0: 5/300, 5/300 and 4/300 mismatch=
es in three `nanosleep` runs. Clang 18.1.3 also reproduces it (3/300). The =
`getpid` control was clean in all three control runs (two GCC, one Clang).<=
br><br>The first mismatch reports:<br>First mismatch: 8192/8192 bytes are z=
ero; TILECFG unchanged<br><br>`nanosleep` returns successfully. The failure=
 is intermittent, so a clean run may need repeating.<br><br>Environment:<br=
>Ubuntu 24.04, custom Linux 6.12.94+<br>#1 SMP PREEMPT_DYNAMIC Mon Sep 7 16=
:15:06 UTC 2026<br>Intel Xeon, family 6, model 207, stepping 2; 4 vCPUs<br>=
KVM reported by the guest; host kernel and VMM unknown<br><br>A separate te=
st also loses tile data in a busy loop under CPU contention, without any sy=
scall while the tiles are live. This suggests an AMX state-preservation iss=
ue around scheduling, but I cannot tell whether the fault is in the custom =
guest kernel or the host environment.<br><br>Does this resemble a known iss=
ue?<br>Any suggestions for narrowing it down from inside the guest would be=
 appreciated.<br><br>Thanks,<br>Joshua Melka</div>

--000000000000354651065b1354d4--
--000000000000354652065b1354d6
Content-Type: text/x-csrc; charset="US-ASCII"; name="amx_min.c"
Content-Disposition: attachment; filename="amx_min.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtulh8yy0>
X-Attachment-Id: f_mtulh8yy0

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVCAqLwojZGVmaW5lIF9HTlVfU09VUkNFCiNp
bmNsdWRlIDxjcHVpZC5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGltbWludHJpbi5o
PgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL3N5
c2NhbGwuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKc3RhdGljIF9B
bGlnbmFzKDY0KSB1bnNpZ25lZCBjaGFyIGNmZ1s2NF0sIGNmZ19hZnRlcls2NF07CnN0YXRpYyBf
QWxpZ25hcyg2NCkgdW5zaWduZWQgY2hhciBzcmNbOF1bMTAyNF0sIGRzdFs4XVsxMDI0XTsKc3Rh
dGljIGNvbnN0IHN0cnVjdCB0aW1lc3BlYyBkZWxheSA9IHsgLnR2X25zZWMgPSAxMDAwMDAwIH07
CiNkZWZpbmUgVElMRVMoT1ApIE9QKDApOyBPUCgxKTsgT1AoMik7IE9QKDMpOyBPUCg0KTsgT1Ao
NSk7IE9QKDYpOyBPUCg3KQojZGVmaW5lIExPQUQodCkgX3RpbGVfbG9hZGQodCwgc3JjW3RdLCA2
NCkKI2RlZmluZSBTVE9SRSh0KSBfdGlsZV9zdG9yZWQodCwgZHN0W3RdLCA2NCkKCi8qIE5vIGZ1
bmN0aW9uIGNhbGxzIGZyb20gTERUSUxFQ0ZHIHVudGlsIFRJTEVSRUxFQVNFLiAqLwpfX2F0dHJp
YnV0ZV9fKChub2lubGluZSkpIGxvbmcgcm91bmR0cmlwKGxvbmcgbnIpCnsKICAgIF90aWxlX2xv
YWRjb25maWcoY2ZnKTsKICAgIFRJTEVTKExPQUQpOwogICAgbG9uZyByZXQ7CiAgICBfX2FzbV9f
IHZvbGF0aWxlKCJzeXNjYWxsIiA6ICI9YSIocmV0KQogICAgICAgIDogIjAiKG5yKSwgIkQiKCZk
ZWxheSksICJTIigwTCkKICAgICAgICA6ICJyY3giLCAicjExIiwgIm1lbW9yeSIsICJjYyIpOwog
ICAgX3RpbGVfc3RvcmVjb25maWcoY2ZnX2FmdGVyKTsKICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
NjQ7IGkrKykgewogICAgICAgIGlmIChjZmdbaV0gIT0gKCh2b2xhdGlsZSB1bnNpZ25lZCBjaGFy
ICopY2ZnX2FmdGVyKVtpXSkgewogICAgICAgICAgICBfdGlsZV9yZWxlYXNlKCk7CiAgICAgICAg
ICAgIHJldHVybiAtNDA5NjsgLyogQ29uZmlndXJhdGlvbiBjaGFuZ2VkOyBkbyBub3Qgc3RvcmUg
dGlsZXMuICovCiAgICAgICAgfQogICAgfQogICAgVElMRVMoU1RPUkUpOwogICAgX21tX21mZW5j
ZSgpOwogICAgX3RpbGVfcmVsZWFzZSgpOwogICAgcmV0dXJuIHJldDsKfQoKaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQp7CiAgICBpZiAoYXJnYyA+IDIgfHwgKGFyZ2MgPT0gMiAmJiBz
dHJjbXAoYXJndlsxXSwgImdldHBpZCIpKSkgewogICAgICAgIGZwcmludGYoc3RkZXJyLCAiVXNh
Z2U6ICVzIFtnZXRwaWRdXG4iLCBhcmd2WzBdKTsKICAgICAgICByZXR1cm4gMjsKICAgIH0KICAg
IHVuc2lnbmVkIGEsIGIsIGMsIGQ7CiAgICBpZiAoIV9fZ2V0X2NwdWlkX2NvdW50KDcsIDAsICZh
LCAmYiwgJmMsICZkKSB8fCAhKGQgJiAoMXUgPDwgMjQpKSkgewogICAgICAgIHB1dHMoIlNLSVA6
IEFNWF9USUxFIG5vdCBleHBvc2VkIik7CiAgICAgICAgcmV0dXJuIDc3OwogICAgfQogICAgaWYg
KHN5c2NhbGwoU1lTX2FyY2hfcHJjdGwsIDB4MTAyMyAvKiBBUkNIX1JFUV9YQ09NUF9QRVJNICov
LCAxOEwpKSB7CiAgICAgICAgcGVycm9yKCJBUkNIX1JFUV9YQ09NUF9QRVJNIik7CiAgICAgICAg
cmV0dXJuIDc3OwogICAgfQogICAgY2ZnWzBdID0gMTsKICAgIGZvciAoaW50IHQgPSAwOyB0IDwg
ODsgdCsrKSB7CiAgICAgICAgY2ZnWzE2ICsgMip0XSA9IDY0OwogICAgICAgIGNmZ1s0OCArIHRd
ID0gMTY7CiAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAxMDI0OyBpKyspCiAgICAgICAgICAg
IHNyY1t0XVtpXSA9IDEgKyAoKHQqMTAyNCArIGkpICUgMjUxKTsKICAgIH0KICAgIGludCBiYWQg
PSAwOwogICAgZm9yIChpbnQgbiA9IDA7IG4gPCAzMDA7IG4rKykgewogICAgICAgIG1lbXNldChk
c3QsIDB4Y2MsIHNpemVvZiBkc3QpOwogICAgICAgIG1lbXNldChjZmdfYWZ0ZXIsIDB4Y2MsIHNp
emVvZiBjZmdfYWZ0ZXIpOwogICAgICAgIGxvbmcgcmV0ID0gcm91bmR0cmlwKGFyZ2MgPT0gMiA/
IFNZU19nZXRwaWQgOiBTWVNfbmFub3NsZWVwKTsKICAgICAgICBpZiAocmV0ID09IC00MDk2KSB7
IHB1dHMoIkZBSUw6IFRJTEVDRkcgY2hhbmdlZCIpOyByZXR1cm4gMjsgfQogICAgICAgIGlmIChy
ZXQgPCAwKSB7IGVycm5vID0gKGludCktcmV0OyBwZXJyb3IoInN5c2NhbGwiKTsgcmV0dXJuIDI7
IH0KICAgICAgICBpZiAobWVtY21wKHNyYywgZHN0LCBzaXplb2Ygc3JjKSkgewogICAgICAgICAg
ICBpZiAoYmFkKysgPT0gMCkgewogICAgICAgICAgICAgICAgaW50IHplcm9zID0gMDsKICAgICAg
ICAgICAgICAgIGZvciAoaW50IHQgPSAwOyB0IDwgODsgdCsrKQogICAgICAgICAgICAgICAgICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgMTAyNDsgaSsrKSB6ZXJvcyArPSBkc3RbdF1baV0gPT0gMDsK
ICAgICAgICAgICAgICAgIHByaW50ZigiRmlyc3QgbWlzbWF0Y2g6ICVkLzgxOTIgYnl0ZXMgYXJl
IHplcm87IFRJTEVDRkcgdW5jaGFuZ2VkXG4iLCB6ZXJvcyk7CiAgICAgICAgICAgIH0KICAgICAg
ICB9CiAgICB9CiAgICBwcmludGYoIiVkLzMwMCB0cmlhbHMgbG9zdCB0aWxlIGRhdGEgKCVzKVxu
IiwgYmFkLCBhcmdjID09IDIgPyAiZ2V0cGlkIiA6ICJuYW5vc2xlZXAiKTsKICAgIHJldHVybiBi
YWQgPyAxIDogMDsKfQo=
--000000000000354652065b1354d6--
