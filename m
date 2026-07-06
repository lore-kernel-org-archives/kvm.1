Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE217416121
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342471; cv=none; b=VPPkAnrGrficZ0JRdSFJERzuKcmDjF2DmP0VPngRdPCbKTNuJqIK2FlAlhUJLDPLbsabVulsMIthm0FphtwcLlx67jWQgqR3NSnIB1SeORDWOOiWgzVTXTxkYlItyv83rKskjw7qr3wQewO+OVUa7z16nYoxQ5mmll6nCLkVfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342471; c=relaxed/simple;
	bh=ev9TNnw8x9m9l5HmAYMhEjTZybjblq9VWu37R67PYjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPvw4CYye+UMpUXZ4X3xkdVwpYcWS7+7g6FBK3Ai9VmXwQvwBiTnC5jIGKlY0Ao1SQxqBG9ijIoddVQzledwnIrQaVnrHat3cqbVbS4pAPPyN92yHofUXw0fgYc/FEY0CBULEiTKxsYJKnUP8HJoRltHmlZtKSvYqFkOvNOOVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzCn6lKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzCn6lKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjErVZm9Wr2QI+kVTSz8W7d34vni0oT36iz299wkMnA=;
	b=HzCn6lKkG3++DvPuVq+/jQ1EsenC3Xv5YV9F8FcQeHF593I3uhl6aaxpJS/1xYt4EWD+Gq
	eXVkPuPGqizo0adagpgqiz3JTurUKKtdxHPrAxAnE2lxvuXQDWmOhCSsjVykBq65eMTqTy
	OifreYWjbj6NKnnJey31QuU7EELXfm4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-0UuMTXsuMQK_B2gMTSjV4g-1; Mon,
 06 Jul 2026 08:54:27 -0400
X-MC-Unique: 0UuMTXsuMQK_B2gMTSjV4g-1
X-Mimecast-MFC-AGG-ID: 0UuMTXsuMQK_B2gMTSjV4g_1783342466
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C50A18009C3;
	Mon,  6 Jul 2026 12:54:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C5203000715;
	Mon,  6 Jul 2026 12:54:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:51 +0400
Subject: [PATCH 4/5] ui/vnc: use RFB wire types for client message handlers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4266;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ev9TNnw8x9m9l5HmAYMhEjTZybjblq9VWu37R67PYjM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnNG2P1La5hNCD/TfhGcAh2IepUbEYvhYZX
 W+yjpr22eyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5YPNEAC0DhcSsO7EYZTArxnP8kXhDTGXHR5k+gBDzLeJFpskrTu2jfvqov+vAXCRAkU17RyJKVb
 XYkpGosSnio4Ss9hJu25QlBi1WMkalbTLl39sI6WpoBDEGBPkLfk2wRcs9KrIYZz3awV0f8/SSG
 nLug9vPpABRCLvZ4aFlvQQrUhNjwb5zQf5saD27a+wUVGntGWTRcZLP7yFdN1qTnWWXhwWq9jiJ
 kK0vhmUcpk+K3q0I8gNTeyzOsxFfb7lDR3XFwagTA+1Qu7UW0k9km8cL6D0X6IwxnAh3jlMG95y
 mmBDI4Zdu+ggp7SScIOKLo/+Q0+1D1JtIP1rgstZniqvxWZG8MHrp/u5eSMMCuD4Vdo3EUoyn7U
 fXzM78WIv1wPH7+Qd9IfCpjF/RlOj6fukng2fvw2zpMuDw8ot9UmRasaOST3ud4+srEoOGdRdG6
 KFF6Hk+04/at7gIy2hLP6YKTt7x8aTnpRKhnDvooPJDZZRL67W9mDN27nyBSYgAfFhspQkaRinz
 hRp7Mh4gemRtNN3Cq/UJJGkJLCe/XmS78fFO9Adyk1Hh+4TbaZ9/5IYF8fj8Wcd4WUyKMzhQG2w
 032mF8gFEjdDPfS/2uZtIkGBpSR3pxAzoWu420x6hvroCCAkYett3kivI5DzU7fw0MZgbNJq2Wi
 XuQ/Am748sAzM2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Use exact-width unsigned types for the static functions that process
RFB client messages, matching the types returned by read_u8(),
read_u16(), and read_u32():

 - set_pixel_format: uint8_t/uint16_t for pixel format fields
 - pointer_event: uint8_t button_mask, uint16_t x/y
 - key_event/ext_key_event: bool down, uint32_t sym/keycode
 - do_key_event: uint32_t sym
 - framebuffer_update_request: uint8_t incremental, uint16_t x/y/w/h

Drop needless declarations.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 94a38242c56..14ce2816907 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -608,15 +608,7 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
    3) resolutions > 1024
 */
 
-static int vnc_update_client(VncState *vs, int has_dirty);
-static void vnc_disconnect_start(VncState *vs);
-
 static void vnc_colordepth(VncState *vs);
-static void framebuffer_update_request(VncState *vs, int incremental,
-                                       int x_position, int y_position,
-                                       int w, int h);
-static void vnc_refresh(DisplayChangeListener *dcl);
-static int vnc_refresh_server_surface(VncDisplay *vd);
 
 static int vnc_width(VncDisplay *vd)
 {
@@ -1763,7 +1755,8 @@ static void check_pointer_type_change(Notifier *notifier, void *data)
     vs->absolute = absolute;
 }
 
-static void pointer_event(VncState *vs, int button_mask, int x, int y)
+static void pointer_event(VncState *vs, uint8_t button_mask,
+                          uint16_t x, uint16_t y)
 {
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]       = 0x01,
@@ -1841,7 +1834,7 @@ static void kbd_leds(Notifier *notifier, void *data)
     }
 }
 
-static void do_key_event(VncState *vs, int down, int keycode, int sym)
+static void do_key_event(VncState *vs, int down, int keycode, uint32_t sym)
 {
     unsigned int lnx = qemu_input_key_number_to_linux(keycode);
 
@@ -2019,7 +2012,7 @@ static const char *code2name(int keycode)
     return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
 }
 
-static void key_event(VncState *vs, int down, uint32_t sym)
+static void key_event(VncState *vs, bool down, uint32_t sym)
 {
     int keycode;
     int lsym = sym;
@@ -2034,8 +2027,8 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     do_key_event(vs, down, keycode, sym);
 }
 
-static void ext_key_event(VncState *vs, int down,
-                          uint32_t sym, uint16_t keycode)
+static void ext_key_event(VncState *vs, bool down,
+                          uint32_t sym, uint32_t keycode)
 {
     /* if the user specifies a keyboard layout, always use it */
     if (keyboard_layout) {
@@ -2046,8 +2039,9 @@ static void ext_key_event(VncState *vs, int down,
     }
 }
 
-static void framebuffer_update_request(VncState *vs, int incremental,
-                                       int x, int y, int w, int h)
+static void framebuffer_update_request(VncState *vs, uint8_t incremental,
+                                       uint16_t x, uint16_t y,
+                                       uint16_t w, uint16_t h)
 {
     if (incremental) {
         if (vs->update != VNC_STATE_UPDATE_FORCE) {
@@ -2250,10 +2244,11 @@ static void send_color_map(VncState *vs)
     vnc_unlock_output(vs);
 }
 
-static void set_pixel_format(VncState *vs, int bits_per_pixel,
-                             int big_endian_flag, int true_color_flag,
-                             int red_max, int green_max, int blue_max,
-                             int red_shift, int green_shift, int blue_shift)
+static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
+                             uint8_t big_endian_flag, uint8_t true_color_flag,
+                             uint16_t red_max, uint16_t green_max,
+                             uint16_t blue_max, uint8_t red_shift,
+                             uint8_t green_shift, uint8_t blue_shift)
 {
     if (!true_color_flag) {
         /* Expose a reasonable default 256 color map */

-- 
2.55.0

