Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563326;
	b=Kq/c2N7E4cX94V+SaB8lD8bjlsgSVMv+v10QSJJnmEFgFG3jl9Lla9TvsgVK3BFqMhhI
	 bInJ63OFvI/VRpZpCZesPoqp9QRte/vvcldcCKUAYqZ7DIFMGluxy9oPT1kWUtGhkvcqb
	 iL7T/qRL3v0RRIxxODtS1RCDUnhNbklrKKNk9TDxvAHfnDqv1HtmbEZ0MjoWsCoKlB3AQ
	 3lhhiXqP1JUAEXCj7sghvKm3qW2msdBVZLVDFe3sMIqYT4yXl4AL2hPlSK8brEozbI6Vs
	 XJb3KKiVbuQkw+SAnrD50v/4uBvP8veAvmpwvaDM+xSb1W2pi8MsVtqxZ0q0qO9GqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563326;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=GVp50UHs0h4PoLHadKWOZlhpqKtvB0FTaFtOAgcyRHk=;
	b=CycdZ6u8KgVbH7lKC2noPmhxJBQSzzSaQMcr+SCB/uk7RZklXvuss3eGSDTX11EqjLC2
	 S+jSGj2Xe5LmBa+NBpBM+sTpKTkekR9MjvoJm/qOX/hD9RRVUeNp67uOjrSwlvbgJNDQa
	 7UtsXwObMi9DLD41ZNH+8C2PJ+TSfqRFp2aJ5Z6BLKrVXJqkwPcg+zW6klfUEAQXnPZlQ
	 Oe4BwGSrlcSr1zPYjCdfVlrx2D/9m9KpCFTSlPAmiS0ihzeqCiG0/MUxL7CRCK0nEQ+jL
	 4cuQdD/7Ah5y0tIht6sZEdg8haR162IeB8xVlntNH8Wv1NMLkm9Y8DmIuendyfmrw4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ECdUQGLM;
	arc=none smtp.remote-ip=101.6.4.71
Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B298606A8B5
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B298606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=ECdUQGLM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=GVp50UHs0h4PoLHadKWOZlhpqKtvB0FTaF
	tOAgcyRHk=; b=ECdUQGLM5pUAwH+Sy6QW2o+QVUPo/IfCeWBGucbdydzVVmFyZw
	i4U1ExpP/l7sZv/Z6DN102+hKoGadWQPG51IwwuFkK+P//QxsBr+uNcMdzwzWox2
	YR7ajbSvYQ/IacnGg8nI31S5xiRXHTNUovNQLaaDSAR3kz3hjaFsmRwnQ=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S7;
	Fri, 13 Nov 2026 17:48:32 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	bin.meng@processmission.com,
	tangtao1634@phytium.com.cn,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 05/20] hw/block/m25p80: add the XTX XT25F128 SPI NOR flash
Date: Fri, 13 Nov 2026 17:47:39 +0800
Message-ID: <7b4f63fbe6a92de57d73be15d8bde33d08a27cf5.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDZr4kXrWrCw13JrWUJwb_yoWrGF45pr
	4DXan8Kr40qFy7Ca1fu3srZr1UZr9FgrWxKw4Fq34SgFy7Jwn8Zr1kCrW8KF929r9ay3Wr
	CFs8WrsxWa95Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
	GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
	UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

Add the 16 MiB XTX XT25F128 SPI NOR flash to m25p80 with JEDEC ID
0b 40 18, 64 KiB sectors and 4 KiB erase. XTX parts handle the status
registers, the quad enable bit and the read dummy cycles like Winbond
parts.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/block/m25p80.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index baf798c6b5..bad966d19a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -356,6 +356,7 @@ static const FlashPartInfo known_devices[] = {
     { INFO("w25q32dw",    0xef6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K | ER_32K),
       .sfdp_read = m25p80_sfdp_w25q33pw },
+    { INFO("xt25f128",    0x0b4018,      0,  64 << 10, 256, ER_4K) },
     { INFO("w25x64",      0xef3017,      0,  64 << 10, 128, ER_4K) },
     { INFO("w25q64",      0xef4017,      0,  64 << 10, 128, ER_4K) },
     { INFO("w25q80",      0xef5014,      0,  64 << 10,  16, ER_4K) },
@@ -468,6 +469,7 @@ typedef enum {
     MAN_MACRONIX,
     MAN_NUMONYX,
     MAN_WINBOND,
+    MAN_XTX,
     MAN_SST,
     MAN_ISSI,
     MAN_GENERIC,
@@ -545,6 +547,8 @@ static inline Manufacturer get_man(Flash *s)
         return MAN_NUMONYX;
     case 0xEF:
         return MAN_WINBOND;
+    case 0x0B:
+        return MAN_XTX;
     case 0x01:
         return MAN_SPANSION;
     case 0xC2:
@@ -652,6 +656,9 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     }
     memset(s->storage + offset, 0xff, len);
     flash_sync_area(s, offset, len);
+    if (get_man(s) == MAN_XTX) {
+        s->write_enable = false;
+    }
 }
 
 static inline void flash_sync_dirty(Flash *s, int64_t newpage)
@@ -821,6 +828,7 @@ static void complete_collecting_data(Flash *s)
             }
             break;
         case MAN_WINBOND:
+        case MAN_XTX:
             if (s->len > 1) {
                 s->quad_enable = !!(s->data[1] & 0x02);
             }
@@ -835,6 +843,7 @@ static void complete_collecting_data(Flash *s)
     case WRSR2:
         switch (get_man(s)) {
         case MAN_WINBOND:
+        case MAN_XTX:
             s->quad_enable = !!(s->data[0] & 0x02);
             break;
         default:
@@ -1085,6 +1094,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_WINBOND:
+    case MAN_XTX:
         s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
@@ -1123,6 +1133,7 @@ static void decode_dio_read_cmd(Flash *s)
     /* Dummy cycles modeled with bytes writes instead of bits */
     switch (get_man(s)) {
     case MAN_WINBOND:
+    case MAN_XTX:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
         break;
     case MAN_SPANSION:
@@ -1159,6 +1170,7 @@ static void decode_qio_read_cmd(Flash *s)
     /* Dummy cycles modeled with bytes writes instead of bits */
     switch (get_man(s)) {
     case MAN_WINBOND:
+    case MAN_XTX:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
         s->needed_bytes += 2;
         break;
@@ -1337,6 +1349,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
             s->state = STATE_COLLECTING_VAR_LEN_DATA;
             break;
         case MAN_WINBOND:
+        case MAN_XTX:
             s->needed_bytes = 2;
             s->state = STATE_COLLECTING_VAR_LEN_DATA;
             break;
@@ -1363,6 +1376,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
 
         switch (get_man(s)) {
         case MAN_WINBOND:
+        case MAN_XTX:
             s->needed_bytes = 1;
             s->state = STATE_COLLECTING_DATA;
             s->pos = 0;
@@ -1542,6 +1556,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
             s->quad_enable = true;
             break;
         case MAN_WINBOND:
+        case MAN_XTX:
             s->data[0] = (!!s->quad_enable) << 1;
             s->pos = 0;
             s->len = 1;
@@ -1601,6 +1616,11 @@ static int m25p80_cs(SSIPeripheral *ss, bool select)
         if (s->state == STATE_COLLECTING_VAR_LEN_DATA) {
             complete_collecting_data(s);
         }
+        if (get_man(s) == MAN_XTX &&
+            s->state == STATE_PAGE_PROGRAM &&
+            s->cmd_in_progress != AAI_WP) {
+            s->write_enable = false;
+        }
         s->len = 0;
         s->pos = 0;
         s->state = STATE_IDLE;
-- 
2.53.0

